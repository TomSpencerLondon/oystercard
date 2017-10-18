class JourneyLog
  attr_reader :journeys, :current_journey
  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @current_journey = nil
    @journeys = []
  end

  def start_journey(entry_station)
    @current_journey = @journey_class.new
    @current_journey.start_journey(entry_station)
  end

  def end_journey(exit_station)
    @current_journey.journey_end(exit_station)
    @journeys << @current_journey
  end

  def fare_charge
    @current_journey.fare
  end
end
