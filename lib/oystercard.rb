class Oystercard
  attr_reader :balance, :status

  MIN_BALANCE = 1
  LIMIT = 90
  

  def initialize
    @balance = 0
    @status = false
  end
  
  def top_up(value)
    fail "The card limit is £#{LIMIT}" if (@balance + value) > LIMIT
    
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def in_journey?
    @status
  end

  def touch_in
    fail 'The minimum balance required to touch in is £1' if @balance < MIN_BALANCE
    @status = true
  end

  def touch_out
    @status = false
  end

end