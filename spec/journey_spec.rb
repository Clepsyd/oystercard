require 'journey'

describe Journey do
  let(:entry_station) { double("entry station")}
  let(:exit_station) { double("exit station")}
  subject { described_class.new(entry_station) }

  describe "#initialize" do

    it "stores the entry station in instance variable" do
      expect(subject.entry_station).to eq(entry_station)
    end

  end
  
  describe "#close" do

    it "stores the exit station in instance variable" do
      subject.close(exit_station)
      expect(subject.exit_station).to eq(exit_station)
    end

  end

end