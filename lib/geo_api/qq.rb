require 'net/http'
require 'json'

module GeoApi
  class Qq
    attr_accessor :config

    def initialize(config)
      @config = config
    end

    # 1 GPS坐标
    # 2 sogou经纬度
    # 3 baidu经纬度
    # 4 mapbar经纬度
    # 5 [默认]腾讯、google、高德坐标
    # 6 sogou墨卡托
    def get_location_from_coordinate(longitude, latitude, coordtype = 5)
      params = { location: "%s,%s" % [latitude,longitude], coord_type: coordtype, key: @config.key }
      result = send_request(params)
      if result && result["status"] == 0 && result["result"]
        databack = Hash.new
        databack["address"] = result["result"]["address"]
        databack["province"] = result["result"]["address_component"]["province"]
        databack["city"] = result["result"]["address_component"]["city"]
        databack["region"] = result["result"]["address_component"]["district"]
        databack["detail"] = "#{result["result"]["address_component"]["street"]}#{result["result"]["address_component"]["street_number"]}"
        databack["longitude"] = result["result"]["location"]["lng"].to_s
        databack["latitude"] = result["result"]["location"]["lat"].to_s
        return databack
      else
        return nil
      end
    end

    def get_coordinate_from_string(location, city = nil)
      params = { address: location, key: @config.key }
      result = send_request(params)
      if result && result["status"] == 0 && result["result"]
        return { longitude: result["result"]["location"]["lng"].to_s, latitude: result["result"]["location"]["lat"].to_s }
      else
        return nil
      end
    end

    def formatted_address(location)
      params = { address: location, key: @config.key }
      result = send_request(params)
      if result && result["status"] == 0 && result["result"]
        databack = Hash.new
        databack["province"] = result["result"]["address_components"]["province"]
        databack["city"] = result["result"]["address_components"]["city"]
        databack["region"] = result["result"]["address_components"]["district"]
        databack["detail"] = "#{result["result"]["address_components"]["street"]}#{result["result"]["address_components"]["street_number"]}"
        databack["longitude"] = result["result"]["location"]["lng"].to_s
        databack["latitude"] = result["result"]["location"]["lat"].to_s
        return databack
      else
        return nil
      end
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
