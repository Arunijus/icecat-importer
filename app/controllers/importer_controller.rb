class ImporterController < ApplicationController
  require 'net/http'

  def index
    source = "http://live.icecat.biz/api/?shopname=openIcecat-live&lang=lt&content=&icecat_id=17496464"
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    @result = JSON.parse(data)
  end
end
