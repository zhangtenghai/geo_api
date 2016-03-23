require 'spec_helper'

describe "test location" do
  let(:config) do
    config = GeoApi::Configuration.new
    config.server = 'http://apis.map.qq.com/ws/geocoder/v1/'
    config.key = 'NM2BZ-V3HRG-ZHMQO-IPJQD-Q375T-EPFRZ'
    config.vendor = 'QQ'
    config
  end
  let(:qq_map) { GeoApi::Qq.new(config) }

  it "get location by coordinate" do
    latitude = "39.9834"
    longitude = "116.3229"

    location = qq_map.get_location_from_coordinate(longitude, latitude)
    expect(location["province"]).to eq("北京市")
    expect(location["city"]).to eq("北京市")
    expect(location["region"]).to eq("海淀区")

    latitude = "36.66"
    longitude = "101.76"

    location = qq_map.get_location_from_coordinate(longitude, latitude)
    expect(location["province"]).to eq("青海省")
    expect(location["city"]).to eq("西宁市")
    expect(location["region"]).to eq("城北区")
  end

  it "get coordinate from string" do
    result = qq_map.get_coordinate_from_string("上海市上海市黄浦区思南路115弄4号")
    p result
    expect(result[:longitude]).not_to be_empty
    expect(result[:latitude]).not_to be_empty

    result = qq_map.get_coordinate_from_string("思南路115弄", "上海市")
    expect(result[:longitude]).not_to be_empty
    expect(result[:latitude]).not_to be_empty

    result = qq_map.get_coordinate_from_string("")
    
    expect(result).to eq(nil)

  end

  it "get format address" do
    result = qq_map.formatted_address("上海市思南路115弄")
    expect(result["province"]).to eq("上海市")
    expect(result["city"]).to eq("上海市")
    expect(result["region"]).to eq("黄浦区")
    expect(result["longitude"]).not_to be_empty
    expect(result["latitude"]).not_to be_empty
  end

end