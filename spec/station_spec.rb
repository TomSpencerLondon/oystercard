require 'station'

describe Station do
  let(:station) {described_class.new("Aldgate East" , 1)}
  describe '#zone' do
    it 'knows what zone a station is in' do
      expect(station.zone).to eq(1)
    end
  end

  describe '#name' do
    it 'knows the name of the station' do
      expect(station.name).to eq("Aldgate East")
    end
  end
end
