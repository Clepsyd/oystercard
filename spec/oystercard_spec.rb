require 'oystercard'

describe Oystercard do
  let(:entry_station) { double("entry station")}
  let(:exit_station) { double("exit station")}
  let(:journey) {{entry_station: entry_station, exit_station: exit_station}}

  context "the card is freshly made" do

    describe 'empty #journey_history' do

      it 'is an empty list by default' do
        expect(subject.journey_history).to eq []
      end

    end

  end

  context "when the user has completed 1 journey and topped up" do

    before do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      subject.top_up(Oystercard::MINIMUM_BALANCE)
    end

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
        expect(subject).not_to be_in_journey
      end

    end

    describe "#touch_in" do

      it "sets in_use to true" do
        subject.touch_in(entry_station)
        expect(subject).to be_in_journey
      end
  
      it "raises an error unless there's at least £1 on the card" do
        subject.top_up(-Oystercard::MINIMUM_BALANCE)
        expect{ subject.touch_in(entry_station) }.to raise_error "Insufficient funds to travel!"
      end

    end

    describe "#touch_out" do
  
      it "reduces the balance by journey fare" do
        subject.touch_in(entry_station)
        expect { subject.touch_out(exit_station) }.to change(subject, :balance).by(-Oystercard::FARE_AMOUNT)
      end
  
      it "sets current journey to nil" do
        expect(subject.current_journey).to eq nil
      end
  
    end

  end

end
