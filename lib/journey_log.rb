class JourneyLog

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @current_journey = nil

  end

  def start_journey(entry_station)
    @current_journey = @journey_class.new
    @current_journey.start_journey(entry_station)
  end

  def end_journey(exit_station)
    @current_journey.journey_end(exit_station)

  end
end
