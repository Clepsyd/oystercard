class Oystercard

attr_reader :balance, :entry_station

MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1
FARE_AMOUNT = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    fail "Limit is £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @in_use
  end

  def touch_in(station)
    raise "Insufficient funds to travel!" if @balance < MINIMUM_BALANCE
    @in_use = true
    @entry_station = station
  end

  def touch_out
    @in_use = false
    deduct(FARE_AMOUNT)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
