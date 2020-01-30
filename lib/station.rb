class Station
  def initialize(station, zone)
    @station_name = station
    @station_zone = zone
  end

  def get_name
    @station_name
  end

  def get_zone
    @station_zone
  end
end