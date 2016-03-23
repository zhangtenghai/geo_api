require 'spec_helper'
describe "test location" do
  # it "test manager" do
  #   manager = GeoApi.setup do |config|
  #     config.server = ""
  #     config.vendor = 'QQ'
  #     config.key = ""
  #   end
  #   p manager.proxy.class.name
  #   expect(manager.proxy.class.name).to eq("GeoApi::Qq")
  # end

  it "test api" do
    a = GeoApi::Configuration.new
    # a.vendor = "QQ"
    # qq_map = GeoApi.setup(a)

    # b = GeoApi::Configuration.new
    # b.vendor = "BAIDU"

    # baidu = GeoApi.setup(b)
    qq_map = GeoApi.setup do |config|
      config.server = 'http://apis.map.qq.com/ws/geocoder/v1/'
      config.key = 'NM2BZ-V3HRG-ZHMQO-IPJQD-Q375T-EPFRZ'
      config.vendor = 'QQ'
    end

    # result = qq_map.get_coordinate_from_string("上海市上海市黄浦区思南路115弄4号")
    # p result
    # expect(result[:longitude]).not_to be_empty
    # expect(result[:latitude]).not_to be_empty

    # result = qq_map.get_coordinate_from_string("思南路115弄", "上海市")
    # expect(result[:longitude]).not_to be_empty
    # expect(result[:latitude]).not_to be_empty

    # result = qq_map.get_coordinate_from_string("")
    
    # expect(result).to eq(nil)
    #p qq_map
    baidu = GeoApi.setup do |config|
      config.server = "http://api.map.baidu.com/geocoder/v2/"
      config.key = "m48tmnl9BPwnhNOctmrVKMRa"
      config.vendor = "BAIDU"
    end
  
    # a = GeoApi::Configuration.new
    # a.vendor = "QQ"
    # p a 
    # b = GeoApi::Configuration.new
    # b.vendor = "BAIDU"
    # p a
    # p b
    p qq_map
    p baidu
    # result = baidu.get_coordinate_from_string("上海市上海市黄浦区思南路115弄4号")
    # p result
    # expect(result[:longitude]).not_to be_empty
    # expect(result[:latitude]).not_to be_empty

    # result = baidu.get_coordinate_from_string("思南路115弄", "上海市")
   
    # expect(result[:longitude]).not_to be_empty
    # expect(result[:latitude]).not_to be_empty

    # result = baidu.get_coordinate_from_string("")
    
    # expect(result).to eq(nil)

  end
end