class JourneyLog
  attr_reader :current_journey
  def initialize(journey_class = Journey)
    @current_journey = journey_class.new
    @journeys = []
  end

  def journeys
    @journeys.dup
  end

  def start_journey(entry_station)
    @current_journey.start_journey(entry_station)
  end

  def end_journey(exit_station)
    start_journey(nil) if @current_journey == nil
    @current_journey.journey_end(exit_station)
    @journeys << @current_journey
  end

  def fare_charge
    @current_journey.fare
  end

  def previous_journey_has_no_touch_out?
    @current_journey.journey_without_touch_out?
  end
end
