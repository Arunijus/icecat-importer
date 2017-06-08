class ImporterController < ApplicationController

  require 'net/http'

  def index
    @pj = ImporterController.icecat_map




    @supplier = Supplier.find_by name: "Icecat"
    @shop = Shop.find_by name: "Elfas"
    @product = Product.create(:uuid => SecureRandom.uuid)
    @variation = Variation.create(:product => @product, :position => 1, :uuid => SecureRandom.uuid)

    @pj["product_gtins"].each do |gtin|
      @variationGtin = VariationGtin.create(:supplier => @supplier, :variation => @variation, :value => gtin)
    end
  end

  def self.icecat_map
    source = "http://live.icecat.biz/api/?shopname=openIcecat-live&lang=lt&content=&icecat_id=17496464"
    resp = Net::HTTP.get_response(URI.parse(source))
    parsed_json = ActiveSupport::JSON.decode(resp.body)
    general_info = parsed_json["data"]["GeneralInfo"]

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
        feature_sign = feature["Feature"]["Measure"]["Signs"]["_"]
        feature_value = feature["Value"]
        feats.push({"attribute_id"=>feature_id, "attribute_name"=>feature_name,
          "attribute_value"=>feature_value, "attribute_sign"=>feature_sign})
      end
    end
    return {"product_name"=>product_name, "product_brand"=>product_brand,"product_gtins"=>product_gtins,
          "product_category_id"=>product_category_id,"product_family_id"=> product_family_id,"product_description"=>product_description,
        "attributes"=>feats }



    # return parsed_json
  end

end





#     @product_import = Product.create(:uuid => SecureRandom.uuid)
#     @variation_import = Variation.create(:product => @product_import, :position => 1, :uuid => SecureRandom.uuid)
#     @attribute_import = Attribute.create( :suffix => "m^3", :value_type => "cubic meters")
#     @attribute_value_import = AttributeValue.create(:att => @attribute_import, :identifier => "sel")
#     @attribute_translation_import = AttributeTranslation.create(:locale => "lt", :name => "vonios uždangalai")
