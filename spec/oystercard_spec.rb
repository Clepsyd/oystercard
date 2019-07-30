require 'oystercard'

describe Oystercard do
  let(:entry_station) { double("entry station")}
  let(:exit_station) { double("exit station")}
  let(:journey) {{entry_station: entry_station, exit_station: exit_station}}


  describe "#top_up" do
    it "raises the balance by a certain amount" do
      balance = subject.balance
      subject.top_up(10)
      expect(subject.balance).to eq balance + 10
    end

    it "raises an error when limit is exceeded" do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      expect{ subject.top_up(maximum_balance + 1) }.to raise_error "Limit is £90"
    end
  end

  describe "#in_journey?" do
    it "returns false when the card is not in use" do
      card = Oystercard.new
      expect(card).not_to be_in_journey
    end
  end

  describe "#touch_in" do

    it "sets in_use to true" do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

    it "raises an error unless there's at least £1 on the card" do
      expect{ subject.touch_in(entry_station) }.to raise_error "Insufficient funds to travel!"
    end

    it "records the entry station when touching in" do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
  end

  describe "#touch_out" do
    it "sets in_use to false" do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end

    it "reduces the balance by journey fare" do
      expect { subject.touch_out(exit_station) }.to change(subject, :balance).by(-Oystercard::FARE_AMOUNT)
    end

    it "resets the value of #entry_station to nil" do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq nil
    end

    it "returns the station where touched out" do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end

  end

  describe '#journey_history' do
    it 'gives the user its joyrney history' do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey_history).to include journey
    end
  end

end
