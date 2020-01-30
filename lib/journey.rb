class Journey
  
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @fare = 0
  end
  
  def journey_start
    @entry_station
  end

  def journey_end
    @exit_station
  end

  def fare
    @fare
  end

  def write_journey_start(entry_station)
    @entry_station = entry_station
  end

  def write_journey_end(exit_station)
    @exit_station = exit_station
  end
  
  def get_journey
    "Journey from #{@entry_station} to #{@exit_station}"
  end

  def complete?
    journey_start && journey_end != nil ? true : false
  end

  def calculate
    @fare = complete? ? MINIMUM_FARE : PENALTY_FARE
  end

end