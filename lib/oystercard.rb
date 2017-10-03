class Oystercard
  attr_accessor :balance
  DEFAULT_VALUE = 0
  def initialize(balance = DEFAULT_VALUE)
    @balance = balance
  end

  def add_money(money)
    @balance += money
    @balance
  end
end
