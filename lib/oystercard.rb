class Oystercard
  MAXIMUM_BALANCE = 90
  DEFAULT_BALANCE = 0
  MINIMUM_CHARGE = 1
  PENALTY_FARE = 6

  attr_reader :balance, :journeys, :current_journey

  def initialize(balance = DEFAULT_BALANCE, journey = Journey.new)
    @balance = balance
    @journeys = []
    @current_journey = journey
  end

  def top_up(amount)
    fail "Maximum balance exceeded" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance to touch in" if @balance < MINIMUM_CHARGE
    reset_journey if @current_journey.journey_without_touch_out?
    @current_journey = Journey.new
    @current_journey.start_journey(station)
  end

  def reset_journey
    deduct(@current_journey.fare)
  end

  def touch_out(station)
    @current_journey.journey_end(station)
    deduct(@current_journey.fare)
    @journeys << @current_journey
  end

  def deduct(amount)
    @balance -= amount
  end

  def reinstate_penalty_fare
    @balance += PENALTY_FARE
  end


end
