require 'oystercard'

describe Oystercard do
  it { is_expected.to respond_to :balance }

  describe "#top_up" do
    it "raises the balance by a certain amount" do
      balance = subject.balance
      subject.top_up(10)
      expect(subject.balance).to eq balance + 10
    end
  end
end
