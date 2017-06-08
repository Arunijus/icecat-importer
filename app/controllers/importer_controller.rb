class ImporterController < ApplicationController
  require 'net/http'
  require 'nokogiri'

  LOCALES = ['en', 'lt', 'lv', 'et']

  def index
    # # Read index file for product ids
    # xml_file = File.read(Rails.root + 'lib/docs/files.test.index.xml')
    #
    # doc = Nokogiri::XML.parse(xml_file)
    #
    # count = 0;
    # productIds = []
    # doc.xpath('//file').each do |file|
    #   productIds << file["Product_ID"]
    #   count = count + 1
    # end
    #
    @supplier = Supplier.find_by name: "Icecat"
    @shop = Shop.find_by name: "Elfas"
    @supplierCategory = SupplierCategory.find_by name: "Icecat"
    @category = Category.find_by name: "Icecat"

    @pj = ImporterController.icecat_map(17496464)

    supplier_item = SupplierItem.find_by foreign_id: @pj["icecat_id"]

    unless supplier_item
      @product = Product.create(:uuid => SecureRandom.uuid)
      @variation = Variation.create(:product => @product, :position => 1, :uuid => SecureRandom.uuid)
      @supplierItem = SupplierItem.create(:variation => @variation, :supplier => @supplier, :supplier_category => @supplierCategory, :foreign_id => @pj["icecat_id"], :payload => @pj["data"])

      @pj["product_gtins"].each do |gtin|
        VariationGtin.create(:supplier => @supplier, :variation => @variation, :value => gtin)
      end

      Assortment.create(:product => @product, :shop => @shop, :is_active => 1, :status => 'Approved')

      @data = @pj["data"]

      @pj["attributes"].each do |a|
        supplier_attribute = SupplierAttribute.find_by foreign_id: a["attribute_id"]

        unless supplier_attribute
          @attribute = Attribute.create(:uuid => SecureRandom.uuid, :suffix => a["feature_measure"])
          AttributeTranslation.create(:name => a["attribute_name"], :locale => "lt", :attr => @attribute)
          @attributeValue = AttributeValue.create(:att => @attribute)

          ProductAttributeValue.create(:product => @product,
                                                  :att => @attribute,
                                                  :attribute_value => @attributeValue,
                                                  :supplier => @supplier)

          AttributeValueTranslation.create(:attr_value => a["attribute_value"], :value_hash => a["attribute_value"].hash, :locale => "lt", :attribute_value => @attributeValue)

          @supplierAttribute = SupplierAttribute.create(:att => @attribute, :supplier => @supplier, :foreign_id => a["attribute_id"])
          SupplierAttributeTranslation.create(:name => a["attribute_name"], :locale => "lt", :supplier_attribute => @supplierAttribute)

          @supplierItemAttributeValue = SupplierItemAttributeValue.create(:supplier_item => @supplierItem, :supplier_attribute => @supplierAttribute, :has_duplicates => 0)
          SupplierItemAttributeValueTranslation.create(:supplier_item_attribute_value => @supplierItemAttributeValue, :value => a["attribute_value"], :transformed_value => a["attribute_value"], :last_checked_value => a["attribute_value"], :locale => "lt")
        end
      end

      ProductCategory.create(:product => @product, :category => @category)
      
    end
  end

  def self.icecat_map(product_id)
    source = "http://live.icecat.biz/api/?shopname=openIcecat-live&lang=lt&content=&icecat_id=#{product_id}"
    resp = Net::HTTP.get_response(URI.parse(source))
    parsed_json = ActiveSupport::JSON.decode(resp.body)
    data = resp.body
    general_info = parsed_json["data"]["GeneralInfo"]

    icecat_id = general_info["IcecatId"]
    product_name = general_info["Title"]
    product_brand = general_info["Brand"]
    product_gtins = general_info["GTIN"]
    product_category_id = general_info["Category"]["CategoryID"]
    product_family_id = general_info["ProductFamily"]["ProductFamilyID"]
    product_description = general_info["Description"]["LongDesc"]

    feats = []
    features_groups = parsed_json["data"]["FeaturesGroups"]

    features_groups.each do |features_group|
      feature_group_id = features_group["ID"]
      features_group["Features"].each do |feature|
        feature_id = feature["ID"]
        feature_name = feature["Feature"]["Name"]["Value"]
        feature_measure = feature["Feature"]["Measure"]["Signs"]["_"]
        feature_value = feature["Value"]
        feats.push({"attribute_id"=>feature_id, "attribute_name"=>feature_name,
          "attribute_value"=>feature_value, "attribute_sign"=>feature_measure})
      end
    end

    return {"data"=>data,"product_name"=>product_name, "icecat_id" => icecat_id, "product_brand"=>product_brand,"product_gtins"=>product_gtins,
          "product_category_id"=>product_category_id,"product_family_id"=> product_family_id,"product_description"=>product_description,
        "attributes"=>feats }
  end

end





#     @product_import = Product.create(:uuid => SecureRandom.uuid)
#     @variation_import = Variation.create(:product => @product_import, :position => 1, :uuid => SecureRandom.uuid)
#     @attribute_import = Attribute.create( :suffix => "m^3", :value_type => "cubic meters")
#     @attribute_value_import = AttributeValue.create(:att => @attribute_import, :identifier => "sel")
#     @attribute_translation_import = AttributeTranslation.create(:locale => "lt", :name => "vonios uždangalai")
