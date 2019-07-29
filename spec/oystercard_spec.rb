require 'oystercard'

describe Oystercard do
  it { is_expected.to respond_to :balance }

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
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it "raises an error unless there's at least £1 on the card" do
      expect{ subject.touch_in }.to raise_error "Insufficient funds to travel!"
    end
  end

  describe "#touch_out" do
    it "sets in_use to false" do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it "reduces the balance by journey fare" do
      expect { subject.touch_out }.to change(subject, :balance).by(-Oystercard::FARE_AMOUNT)
    end
  end
end
