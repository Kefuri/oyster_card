require 'oystercard'
describe OysterCard do
  subject(:oyster) { described_class.new }
  let(:station) {double("fake station")}

  it 'returns a balance of 0' do
    expect(oyster.balance).to eq 0
  end

  it ' initializes an empty array' do 
    expect(oyster.journeys).to eq []
  end

  describe "#top_up" do
    it 'increases balance with a top up value' do
      expect { oyster.top_up(10) }.to change { oyster.balance }.from(0).to(10)
    end

    it 'raises an error if balance exceeds limit' do
      oyster.top_up(OysterCard::LIMIT)
      expect{ oyster.top_up(1) }.to raise_error("Cannot top-up over £#{described_class::LIMIT} limit")
    end
  end

  describe "#in_journey?" do
    it 'should return false if card is not tapped in' do
      expect(oyster.in_journey?).to eq(false)
    end

    it 'should return true if card is tapped in' do
      oyster.entry_station = "Liverpool Street"
      expect(oyster).to be_in_journey
    end
  end
  describe "#touch_in" do
    it "should change state to true" do
      min_bal = OysterCard::MINIMUM_BALANCE
      oyster.top_up(min_bal)
      allow(station).to receive(:name) { "Liverpool Street" }
      oyster.touch_in(station.name)
      expect(oyster).to be_in_journey
    end
    it "should raise an error when balance is too low" do
      allow(station).to receive(:name) { "Liverpool Street" }
      expect { oyster.touch_in(station.name) }.to raise_error("Balance too low!")
    end

    it "should remember an entry station when tapped" do
      allow(station).to receive(:name) { "Liverpool Street" }
      oyster.top_up(OysterCard::MINIMUM_BALANCE)
      oyster.touch_in(station.name)
      expect(oyster.entry_station).to eq("Liverpool Street")
    end
  end
  describe "#touch_out" do
    it "should change state to false" do
      min_bal = OysterCard::MINIMUM_BALANCE
      oyster.top_up(min_bal)
      allow(station).to receive(:name).and_return('Liverpool Street', 'Stratford')
      oyster.touch_in(station.name)
      oyster.touch_out(station.name)
      expect(oyster).not_to be_in_journey
    end

    it "should deduct the minimum fare from balance" do
      min_bal = OysterCard::MINIMUM_BALANCE
      oyster.top_up(min_bal)
      allow(station).to receive(:name).and_return('Liverpool Street', 'Stratford')
      oyster.touch_in(station.name)
      expect { oyster.touch_out(station.name) }.to change { oyster.balance }.by(-min_bal)
    end

    it "should forget the entry station when tapping out" do
      allow(station).to receive(:name).and_return('Liverpool Street', 'Stratford')
      oyster.top_up(OysterCard::MINIMUM_BALANCE)
      oyster.touch_in(station.name)
      expect(oyster.touch_out(station.name)).to eq nil
    end

    it "should create a journey once touched out" do
      allow(station).to receive(:name).and_return('Liverpool Street', 'Stratford')
      oyster.top_up(OysterCard::MINIMUM_BALANCE)
      oyster.touch_in(station.name)
      oyster.touch_out(station.name)
      expect(oyster.journeys.length).to eq 1
    end

  end

  describe "#create_journey" do
    it 'responds to create_journey' do
      expect(oyster).to respond_to(:create_journey).with(2).arguments
    end

    it 'should create a hash with the entry and exit journey' do
      allow(station).to receive(:name).and_return('Liverpool Street', 'Stratford')
      oyster.top_up(OysterCard::MINIMUM_BALANCE)
      oyster.touch_in(station.name)
      oyster.touch_out(station.name)
      expect(oyster.journeys[0]).to eq({ :jid =>1, :entry_station => "Liverpool Street", :exit_station => "Stratford" })
    end
  end 
end

# describe OysterCard do
#   subject(:oyster) { described_class.new }
#   let(:station) {double("fake station")}

#   context "requires a top up and touch in" do

#     before(:example) do
#       allow(station).to receive(:name) { 'Liverpool Street' }
#       min_bal = OysterCard::MINIMUM_BALANCE
#       oyster.top_up(min_bal)
#       oyster.touch_in(station.name)
#     end

#     describe "#touch_out" do
#       it "should accept an exit station when tapping out" do
#         expect(oyster).to respond_to(:touch_out).with(1).arguments
#       end
#       it "testing test structure, should be in journey" do
#         oyster.touch_out
#         expect(oyster).not_to be_in_journey
#       end
#       it "should forget the entry station when tapping out" do
#         expect{ oyster.touch_out }.to change { oyster.entry_station }.from(station.name).to(nil)
#       end

#     end
#   end
# end


