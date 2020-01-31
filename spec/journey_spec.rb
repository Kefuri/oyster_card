require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:entry_station) {double("Liverpool Street")}
  let(:exit_station) {double("Hyde Park")}
 
  it "#starts a journey" do
    journey.write_journey_start(entry_station)
    expect(journey.journey_start).to eq(entry_station)
  end

  it "#end a journey" do
    journey.write_journey_end(exit_station)
    expect(journey.journey_end).to eq(exit_station)
  end

  it "#get_journey shows us our journey" do
    journey.write_journey_start(entry_station)
    journey.write_journey_end(exit_station)
    expect(journey.get_journey).to eq("Journey from #{entry_station} to #{exit_station}")
  end

  it "should know that a journey is complete" do
    journey.write_journey_start(entry_station)
    journey.write_journey_end(exit_station)
    expect(journey).to be_complete
  end

  it "should know that a journey is not complete" do
    test_journey = Journey.new("Start")
    expect(test_journey).not_to be_complete
  end

  it "should calculate a fare for a complete journey" do
    journey.write_journey_start(entry_station)
    journey.write_journey_end(exit_station)
    expect(journey.calculate).to eq(Journey::MINIMUM_FARE)
  end

  it "should calculate a fare for a incomplete journey" do
    test_journey = Journey.new("Start")
    expect(test_journey.calculate).to eq(Journey::PENALTY_FARE)
  end
  it "should calculate a fare for an incomplete journey" do
    test_journey = Journey.new(nil, "End")
    expect(test_journey.calculate).to eq(Journey::PENALTY_FARE)
  end
end