class OysterCard
  attr_reader :balance, :entry_station
  attr_accessor :state

  LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @state = false
    @entry_station = nil
  end

  def top_up(amount)
    raise "Cannot top-up over £#{LIMIT} limit" if limit?(amount)

    @balance += amount
  end

  def in_journey?
    @state
  end

  def touch_in(station)
    fail "Balance too low!" unless suff_funds?
    @state = true
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
    @state = false
    @entry_station = nil
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