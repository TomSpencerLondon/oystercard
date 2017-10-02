class Oystercard
  attr_accessor :money
  DEFAULT_VALUE = 0
  def initialize(balance = DEFAULT_VALUE)
    @balance = balance
  end
end
