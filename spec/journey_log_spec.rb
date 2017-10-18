require 'journey_log'

describe JourneyLog do
  let(:journey_class) { Journey }
  let(:entry_station) { Station.new("Aldgate East", 1) }
  let(:exit_station) { Station.new("Victoria", 1)}
  let(:journey_log) { described_class.new(journey_class) }

  describe '#start_journey' do
    it 'starts a journey' do
      expect(journey_log.start_journey(entry_station)).to eq(entry_station)
    end
  end

  describe '#end_journey' do
    it 'ends a journey' do
      journey_log.start_journey(entry_station)
      expect(journey_log.end_journey(exit_station)).to eq(exit_station)
    end
  end


end




#start journey
#end journey
#return a list of journeys
