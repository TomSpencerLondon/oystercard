class Oystercard
  MAXIMUM_BALANCE = 90
  DEFAULT_BALANCE = 0
  MINIMUM_CHARGE = 1

  attr_accessor :balance, :in_use, :entry_station, :exit_station, :journeys, :journey

  def initialize(balance = DEFAULT_BALANCE, minimum = MINIMUM_CHARGE)
    @balance = balance
    @in_journey = false
    @minimum = minimum
    @entry_station = entry_station
    @exit_station = exit_station
    @journeys = []
    @journey = {}
  end

  def top_up(amount)
    fail "Maximum balance exceeded" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station)
    fail "Insufficient balance to touch in" if @balance < @minimum
    @entry_station = station
    @in_journey = true
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    #@entry_station = nil
    @exit_station = station
    @journey[:entry_station] = @entry_station
    @journey[:exit_station] = @exit_station

  end

  def in_journey?
    !!entry_station
  end

end
