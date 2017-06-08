class ImporterController < ApplicationController

  require 'net/http'

  def index
    @supplier = Supplier.find_by name: "Icecat"
    @shop = Shop.find_by name: "Elfas"
    source = "http://live.icecat.biz/api/?shopname=openIcecat-live&lang=lt&content=&icecat_id=17496464"
    resp = Net::HTTP.get_response(URI.parse(source))
    @data = resp.body

    parsed_json = ActiveSupport::JSON.decode(resp.body)


    @product = Product.create(:uuid => SecureRandom.uuid)
    @variation = Variation.create(:product => @product, :position => 1, :uuid => SecureRandom.uuid)
    @gtins = parsed_json["data"]["GeneralInfo"]["GTIN"]

    @gtins.each do |gtin|
      @variationGtin = VariationGtin.create(:supplier => @supplier, :variation => @variation, :value => gtin)
    end
  end
end
