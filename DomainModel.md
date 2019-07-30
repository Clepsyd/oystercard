|Objects              |     Methods          |                      |
|---------------------|----------------------|----------------------|
|Oystercard           |balance               |                      |
|                     |top_up(value)         |-> balance += value   |
|                     |deduct(value)         |-> balance -= value   |
|                     |in_journey?           |-> true or false      |
|                     |touch_in              |-> in_journey -> true |
|                     |touch_out             |-> in_journey -> false|


{ :entry_zone = > card.journey_history.last.entry_station.zone,
exit_zone => card.journey_history.last.exit_station.zone }



