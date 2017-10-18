class JourneyLog

  def initialize(journey_class = Journey)
    @journey_class = journey_class
  end

  def start_journey(entry_station)
    @journey_class = Journey.new
    @journey_class.start_journey(entry_station)
  end

end
