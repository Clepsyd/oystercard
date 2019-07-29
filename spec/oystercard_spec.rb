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
end
