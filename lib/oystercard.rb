class Oystercard

attr_reader :balance, :entry_station

MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1
FARE_AMOUNT = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Limit is £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    raise "Insufficient funds to travel!" if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out
    deduct(FARE_AMOUNT)
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
