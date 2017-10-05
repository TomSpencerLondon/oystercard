class Oystercard
  MAXIMUM_BALANCE = 90
  DEFAULT_BALANCE = 0
  attr_accessor :balance, :in_use

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_use = false
  end

  def top_up(amount)
    fail "Maximum balance exceeded" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

end
