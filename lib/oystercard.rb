class Oystercard
  MAXIMUM_BALANCE = 90
  DEFAULT_BALANCE = 0
  MINIMUM_CHARGE = 1

  attr_accessor :balance, :in_use, :entry_station, :exit_station, :amount

  def initialize(balance = DEFAULT_BALANCE, minimum = MINIMUM_CHARGE)
    @balance = balance
    @in_journey = false
    @minimum = minimum
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def top_up(amount)
    fail "Maximum balance exceeded" if balance_exceeded?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station)
    fail "Insufficient balance to touch in" if no_cash?
    @entry_station = station
    @in_journey = true
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @entry_station = nil
    @exit_station = station
  end

  def in_journey?
    !!entry_station
  end

  private

  def balance_exceeded?(amount)
    amount + @balance > MAXIMUM_BALANCE
  end

  def no_cash?
    @balance < @minimum
  end


end
