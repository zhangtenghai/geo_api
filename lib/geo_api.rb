require "geo_api/version"
require 'geo_api/configuration'
require "geo_api/baidu"
require "geo_api/gaode"
require "geo_api/qq"
require "geo_api/manager"
require 'logger'

module GeoApi
  class << self
    def setup
      yield config
      Manager.new(config)
    end

    def config
      @config ||= Configuration.new
    end
  end
end