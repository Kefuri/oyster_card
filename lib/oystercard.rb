class OysterCard
  attr_reader :balance, :journeys
  attr_accessor :entry_station

  LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    raise "Cannot top-up over £#{LIMIT} limit" if limit?(amount)

    @balance += amount
  end

  def in_journey?
    @entry_station ? true : false
  end

  def touch_in(station)
    fail "Balance too low!" unless suff_funds?
    @entry_station = station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_BALANCE)
    @entry_station = nil
  end

  def create_journey(entry_station, exit_station)
    journey = {"JID" => (@journeys.length + 1), "Entry" => entry_station, "Exit" => exit_station}
  end
  
  private
  def suff_funds?
    @balance >= MINIMUM_BALANCE
  end

  def deduct(fare)
    @balance -= fare
  end

  def limit?(amount)
    @balance + amount > LIMIT
  end
end