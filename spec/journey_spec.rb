require 'journey'

describe Journey do
  subject(:journey) { described_class.new("Liverpool Street", "Hyde Park") }
 
  it "#starts a journey" do
    expect(journey.journey_start).to eq("Liverpool Street")
  end

  it "#end a journey" do
    expect(journey.journey_end).to eq("Hyde Park")
  end

  it "#get_journey shows us our journey" do
    expect(journey.get_journey).to eq("Journey from Liverpool Street to Hyde Park")
  end

  it "should know that a journey is complete" do
    expect(journey).to be_complete
  end

  it "should know that a journey is not complete" do
    test_journey = Journey.new("Start")
    expect(test_journey).not_to be_complete
  end

  it "should calculate a fare for a complete journey" do
    expect(journey.calculate).to eq(Journey::MINIMUM_FARE)
  end

  it "should calculate a fare for a incomplete journey" do
    test_journey = Journey.new("Start")
    expect(test_journey.calculate).to eq(Journey::PENALTY_FARE)
  end
end