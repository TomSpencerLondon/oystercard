require 'journey_log'

describe JourneyLog do
  let(:journey) { double :journey }
  let(:journey_class){double :journey_class, new: journey}
  let(:entry_station) { double :station, name: 'Aldgate East', zone: 1 }
  let(:exit_station) { double :station, name: 'Victoria', zone: 1 }
  let(:journey_log) { described_class.new(journey_class) }
  let(:minimum_charge) { 1 }

  before do
    allow(journey).to receive(:start_journey).and_return(entry_station)
    allow(journey).to receive(:journey_end).and_return(exit_station)
    allow(journey).to receive(:fare).and_return(minimum_charge)
  end

  describe '#start_journey' do
    it 'starts a journey' do
      expect(journey_log.start_journey(entry_station)).to eq(entry_station)
    end
  end

  describe '#end_journey' do
    it 'ends a journey' do
      journey_log.start_journey(entry_station)
      expect(journey_log.end_journey(exit_station)).to eq(journey_log.journeys)
    end
  end

  describe '#log_journeys' do
    it 'logs a list of past journeys' do
      journey_log.start_journey(entry_station)
      journey_log.end_journey(exit_station)
      expect(journey_log.journeys).to include(journey_log.current_journey)
    end
  end

  describe '#fare_charge' do
    it 'charges a minimum fare for a complete journey' do
      journey_log.start_journey(entry_station)
      journey_log.end_journey(exit_station)
      expect(journey_log.fare_charge).to eq(1)
    end
  end

end




#start journey
#end journey
#return a list of journeys
