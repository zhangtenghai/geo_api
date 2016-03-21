require 'net/http'
require 'json'

module GeoApi
  class Baidu
    attr_accessor :config

    def initialize(config)
      @config = config
    end

    def get_location_from_coordinate(latitude, longitude, coordtype = 'bd09ll')
      params = { location: "%s,%s" % [longitude,latitude], coordtype: coordtype, ak: @config.key }
      result = send_request(params)
      
      if result && result["status"] == 0 && result["result"]
        databack = Hash.new
        databack["address"] = result["result"]["formatted_address"]
        databack["province"] = result["result"]["addressComponent"]["province"]
        databack["city"] = result["result"]["addressComponent"]["city"]
        databack["region"] = result["result"]["addressComponent"]["district"]
        databack["detail"] = "#{result["result"]["addressComponent"]["street"]}#{result["result"]["addressComponent"]["street_number"]}"
        return databack
      else
        return nil
      end
    end

    def get_coordinate_from_string(location, city = nil)
      params = { address: location, region: city, ak: @config.key }
      result = send_request(params)
      if result["status"] == 0
        return { longitude: result["result"]["location"]["lng"].to_s, latitude: result["result"]["location"]["lat"].to_s }
      else
        return nil
      end
    end

    def formatted_address(location)
      nil
    end

    private
    def send_request(params)
      uri = URI(@config.server)
      params[:output] = 'json'
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)
      result = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)# && !res.body.blank?

      return result
    end
  end
end
