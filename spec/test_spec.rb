require 'spec_helper'
describe "test location" do
  it "test manager" do
    manager = GeoApi.setup do |config|
      config.server = ""
      config.vendor = 'QQ'
      config.key = ""
    end
    p manager.proxy.class.name
    expect(manager.proxy.class.name).to eq("GeoApi::Qq")
  end
end