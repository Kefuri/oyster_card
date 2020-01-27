require 'oystercard'
describe OysterCard do
  subject(:oyster) { described_class.new }
  it 'returns a balance of 0' do
    expect(oyster.balance).to eq 0
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

  describe "#deduct" do
    it 'should deduct the specified fare from balance' do
      oyster.top_up(10)
      expect { oyster.deduct(8) }.to change { oyster.balance }.by -8
    end
  end

  describe "#in_journey?" do
    it 'should return false if card is not tapped in' do
      expect(oyster.in_journey?).to eq(false)
    end

    it 'should return true if card is tapped in' do
      oyster.state = true
      expect(oyster).to be_in_journey
    end
  end
  describe "#touch_in" do
    it "should change state to true" do
      min_bal = OysterCard::MINIMUM_BALANCE
      oyster.top_up(min_bal)
      oyster.touch_in
      expect(oyster).to be_in_journey
    end
    it "should raise an error when balance is too low" do
      expect { oyster.touch_in }.to raise_error("Balance too low!")
    end
      
  end
  describe "#touch_out" do
    it "should change state to false" do
      min_bal = OysterCard::MINIMUM_BALANCE
      oyster.top_up(min_bal)
      oyster.touch_in
      oyster.touch_out
      expect(oyster).not_to be_in_journey
    end
  end

end
