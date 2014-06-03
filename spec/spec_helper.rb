# encoding utf-8
require 'bundler/setup'
require 'geo_api'

Bundler.setup

GeoApi.setup do |config|
  config.server = "http://api.map.baidu.com/geocoder/v2/"
  config.key = "09f24306fde8dd0f7e73a3f977c2c584"
end

RSpec.configure do |config|
  config.before(:each) do

  end
end