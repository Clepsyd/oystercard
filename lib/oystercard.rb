class Oystercard

attr_reader :balance, :entry_station, :exit_station, :journey_history

MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1
FARE_AMOUNT = 1

  def initialize
    @balance = 0
    @journey_history = []
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

  def touch_out(station)
    deduct(FARE_AMOUNT)
    @exit_station = station
    journey_history << {entry_station:  entry_station, exit_station: exit_station}
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
