require_relative './journey.rb'

class Oystercard

attr_reader :balance, :journey_history, :current_journey

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
    @current_journey != nil
  end

  def touch_in(station)
    raise "Insufficient funds to travel!" if @balance < MINIMUM_BALANCE
    @journey_history << Journey.new(station)
    @current_journey = @journey_history.last
  end

  def touch_out(station)

    deduct(FARE_AMOUNT)
    @current_journey.close(station)
    @current_journey = nil

  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
