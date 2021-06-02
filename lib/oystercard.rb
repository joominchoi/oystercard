class Oystercard
  attr_reader :balance

  LIMIT = 90

  def initialize
    @balance = 0
  end
  
  def top_up(value)
    fail "The card limit is £#{LIMIT}" if (@balance + value) > LIMIT
    
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

end