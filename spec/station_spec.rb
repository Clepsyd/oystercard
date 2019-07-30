require 'station'

describe Station do
  subject {Station.new('Aldgate',1)}

  it 'tell us what its name is' do
    expect(subject.name).to eq 'Aldgate'
  end

  it 'tells us which zone were in' do
    expect(subject.zone).to eq 1
  end

end