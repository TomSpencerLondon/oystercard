class Journey

MINIMUM_CHARGE = 1
PENALTY_FARE = 6

attr_reader :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start_journey(entry_station)
    @entry_station = entry_station
  end

  def journey_complete?
    !!@entry_station && !!@exit_station
  end

  def journey_without_touch_out?
    @entry_station != nil && @exit_station == nil
  end

  def journey_end(exit_station)
    @exit_station = exit_station
  end

  def absolute_zone_difference
    (@entry_station.zone - @exit_station.zone).abs
  end


  def fare
    return MINIMUM_CHARGE + absolute_zone_difference if journey_complete?
    PENALTY_FARE
  end

end
