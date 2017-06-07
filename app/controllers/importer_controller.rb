class ImporterController < ApplicationController

  require 'net/http'

  def index
    # source = "http://live.icecat.biz/api/?shopname=openIcecat-live&lang=lt&content=&icecat_id=17496464"
    # resp = Net::HTTP.get_response(URI.parse(source))
    # @data = resp.body

    @product = Product.create(:uuid => SecureRandom.uuid)
    @variation = Variation.create(:product => @product, :position => 1, :uuid => SecureRandom.uuid)
  end
end
