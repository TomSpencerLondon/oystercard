require 'journey_log'

class Oystercard
  MAXIMUM_BALANCE = 90
  DEFAULT_BALANCE = 0
  MINIMUM_CHARGE = 1


  attr_reader :balance

  def initialize(balance = DEFAULT_BALANCE, journey_log = JourneyLog.new)
    @balance = balance
    @journey_log = journey_log
  end

  def top_up(amount)
    fail "Maximum balance exceeded" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance to touch in" if @balance < MINIMUM_CHARGE
    reset_journey if @journey_log.previous_journey_has_no_touch_out?
    @journey_log.start_journey(station)
  end

  def reset_journey
    deduct(@journey_log.fare_charge)
  end

  def touch_out(station)
    @journey_log.end_journey(station)
    deduct(@journey_log.fare_charge)
  end

  def deduct(amount)
    @balance -= amount
  end

end
