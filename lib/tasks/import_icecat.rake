require 'rake'
require 'net/http'
require 'nokogiri'

LOCALES = ['en', 'lt', 'lv', 'et']

namespace :icecat do
  task :import => :environment do
    productIds = ["17496464"]

    # Read index file for product ids
    xml_file = File.read(Rails.root + 'lib/docs/index_file_1.xml')

    doc = Nokogiri::XML.parse(xml_file)

    count = 1;
    doc.xpath('//file').each do |file|
      productIds << file["Product_ID"]
      count = count + 1
    end

    puts "Total #{count} products found in index file. Starting import..."
    progress_bar = ProgressBar.new(count)

    @supplier = Supplier.find_by name: "Icecat"
    @shop = Shop.find_by name: "Elfas"
    @supplierCategory = SupplierCategory.find_by name: "Icecat"
    @category = Category.find_by name: "Icecat"
    @titleAttribute = Attribute.find_by special_type: "title"
    @descriptionAttribute = Attribute.find_by special_type: "description"
    @supplierTitleAttr = SupplierAttribute.find_by foreign_id: "icecat_title"
    @supplierDescriptionAttr = SupplierAttribute.find_by foreign_id: "icecat_description"

    productIds.each do |productId|
      progress_bar.increment
      @pj = icecat_map(productId)
      @data = @pj[:data]

      supplier_item = SupplierItem.find_by foreign_id: @pj[:icecat_id]

      unless supplier_item
        @productFamily = nil
        if @pj[:product_family_id]
          @productFamily = ProductFamily.find_by foreign_id: @pj[:product_family_id]

          unless @productFamily
            @productFamily = ProductFamily.create(:name => @pj[:product_family_name], :foreign_id => @pj[:product_family_id], :is_approved => 0)
          end
        end

        @product = Product.create(:uuid => SecureRandom.uuid, :family => @productFamily)
        @variation = Variation.create(:product => @product, :position => 1, :uuid => SecureRandom.uuid)
        @product.update_attribute(:default_variation, @variation)
        @supplierItem = SupplierItem.create(:variation => @variation, :supplier => @supplier, :supplier_category => @supplierCategory, :foreign_id => @pj[:icecat_id], :payload => @pj[:data])

        @pj[:product_gtins].each do |gtin|
          VariationGtin.create(:supplier => @supplier, :variation => @variation, :value => gtin)
        end

        ProductCategory.create(:product => @product, :category => @category)

        Assortment.create(:product => @product, :shop => @shop, :is_active => 1, :status => 'Approved')

        # Add product title
        @supplierTitleAttrValue = SupplierItemAttributeValue.create(:supplier_item => @supplierItem, :supplier_attribute => @supplierTitleAttr, :has_duplicates => 0)
        SupplierItemAttributeValueTranslation.create(:supplier_item_attribute_value => @supplierTitleAttrValue, :value => @pj[:product_name], :transformed_value => @pj[:product_name], :last_checked_value => @pj[:product_name], :locale => "lt")
        @titleAttrValue = AttributeValue.create(:att => @titleAttribute, :uuid => SecureRandom.uuid)
        AttributeValueTranslation.create(:attribute_value => @titleAttrValue, :attr_value => @pj[:product_name], :value_hash => @pj[:product_name].hash, :locale => "lt")
        ProductAttributeValue.create(:product => @product, :att => @titleAttribute, :attribute_value => @titleAttrValue, :supplier => @supplier)

        # Add product description
        @supplierDescriptionAttrValue = SupplierItemAttributeValue.create(:supplier_item => @supplierItem, :supplier_attribute => @supplierDescriptionAttr, :has_duplicates => 0)
        SupplierItemAttributeValueTranslation.create(:supplier_item_attribute_value => @supplierDescriptionAttrValue, :value => @pj[:product_description], :transformed_value => @pj[:product_description], :last_checked_value => @pj[:product_description], :locale => "lt")
        @descriptionAttrValue = AttributeValue.create(:att => @descriptionAttribute, :uuid => SecureRandom.uuid)
        AttributeValueTranslation.create(:attribute_value => @descriptionAttrValue, :attr_value => @pj[:product_description], :value_hash => @pj[:product_description].hash, :locale => "lt")
        ProductAttributeValue.create(:product => @product, :att => @descriptionAttribute, :attribute_value => @descriptionAttrValue, :supplier => @supplier)

        @pj[:attributes].each do |a|
          supplier_attribute = SupplierAttribute.find_by foreign_id: a["attribute_id"]

          unless supplier_attribute
            @attribute = Attribute.create(:uuid => SecureRandom.uuid, :suffix => a["attribute_sign"], :value_type => a["attribute_type"], :is_translatable => 1)
            AttributeTranslation.create(:name => a["attribute_name"], :locale => "lt", :attr => @attribute)
            @attributeValue = AttributeValue.create(:att => @attribute, :uuid => SecureRandom.uuid)

            ProductAttributeValue.create(:product => @product, :att => @attribute, :attribute_value => @attributeValue, :supplier => @supplier)

            AttributeValueTranslation.create(:attr_value => a["attribute_value"], :value_hash => a["attribute_value"].hash, :locale => "lt", :attribute_value => @attributeValue)

            @supplierAttribute = SupplierAttribute.create(:att => @attribute, :supplier => @supplier, :foreign_id => a["attribute_id"])
            SupplierAttributeTranslation.create(:name => a["attribute_name"], :locale => "lt", :supplier_attribute => @supplierAttribute)

            @supplierItemAttributeValue = SupplierItemAttributeValue.create(:supplier_item => @supplierItem, :supplier_attribute => @supplierAttribute, :has_duplicates => 0)
            SupplierItemAttributeValueTranslation.create(:supplier_item_attribute_value => @supplierItemAttributeValue, :value => a["attribute_value"], :transformed_value => a["attribute_value"], :last_checked_value => a["attribute_value"], :locale => "lt")
          end
        end

        image_position = 0
        @pj[:images].each do |image|
          position = image["isMain"] ? 0 : image_position = image_position + 1
          VariationPhoto.create(:variation => @variation, :source => "Icecat::HTML", :file => image["file"], :position => position, :size => image["size"], :width => image["width"], :height => image["height"], :status => "active")
        end

        link_position = 0
        @pj[:links].each do |link|
          ProductLink.create(:product => @product, :title => link["title"], :url => link["url"], :link_type => link["type"], :position => link_position, :is_active => 1)
          link_position = link_position + 1
        end
      end
    end

    puts "  Import finished."
  end

  def icecat_map(product_id)
    product_data = {}
    source = "http://live.icecat.biz/api/?shopname=openIcecat-live&lang=lt&content=&icecat_id=#{product_id}"
    resp = Net::HTTP.get_response(URI.parse(source))
    parsed_json = ActiveSupport::JSON.decode(resp.body)
    product_data[:data] = resp.body
    general_info = parsed_json["data"]["GeneralInfo"]

    product_data[:icecat_id] = general_info["IcecatId"]
    product_data[:product_name] = general_info["Title"]
    product_data[:product_brand] = general_info["Brand"]
    product_data[:product_gtins] = general_info["GTIN"]
    product_data[:product_category_id] = general_info["Category"]["CategoryID"]

    if general_info["ProductFamily"].any?
      product_data[:product_family_id] = general_info["ProductFamily"]["ProductFamilyID"]
      product_data[:product_family_name] = general_info["ProductFamily"]["Value"]
    end

    if general_info["Description"].any?
      product_data[:product_description] = general_info["Description"]["LongDesc"]
    end

    feats = []
    features_groups = parsed_json["data"]["FeaturesGroups"]

    features_groups.each do |features_group|
      features_group["Features"].each do |feature|
        feature_id = feature["Feature"]["ID"]
        feature_type = feature["Type"]
        feature_name = feature["Feature"]["Name"]["Value"]
        feature_measure = feature["Feature"]["Measure"]["Signs"]["_"]
        feature_value = feature["Value"]

        feats.push({"attribute_id"=>feature_id, "attribute_type" => feature_type, "attribute_name"=>feature_name, "attribute_value"=>feature_value, "attribute_sign"=>feature_measure})
      end
    end

    product_data[:attributes] = feats

    images = []
    gallery = parsed_json["data"]["Gallery"]

    gallery.each do |gallery_item|
      image_file = gallery_item["Pic"]
      image_size = gallery_item["Size"]
      image_width = gallery_item["PicWidth"]
      image_height = gallery_item["PicHeight"]
      is_main = gallery_item["IsMain"] === "Y" ? true : false

      images.push({"file" => image_file, "size" => image_size, "width" => image_width, "height" => image_height, "isMain" => is_main})
    end

    product_data[:images] = images

    links = []
    multimedia = parsed_json["data"]["Multimedia"]

    multimedia.each do |media_item|
      url = media_item["URL"]
      type = media_item["Type"]
      title = media_item["Description"]

      links.push({"url" => url, "type" => type, "title" => title})
    end

    product_data[:links] = links

    return product_data
  end
end
