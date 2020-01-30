require 'station'

describe Station do
  subject(:station) { described_class.new("Liverpool Street", 1) }

  describe "#get_name" do
    it "Should initialize with an instance variable called station_name" do
      expect(station.get_name).to eq "Liverpool Street"
    end
  end

  describe "#get_zone" do
    it "should initialize with an instance variable called station_zone" do
      expect(station.get_zone).to eq 1
    end
  end
end
