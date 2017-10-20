require 'journey'
require 'station'
describe Journey do
  let (:entry_station) { double :station, name: 'Aldgate East', zone: 1 }
  let (:exit_station) { double :station, name: 'Victoria', zone: 1 }
  let(:journey) { described_class.new }

  describe '#start' do
    it 'shows the first station' do
        journey.start_journey(entry_station)
        expect(journey.entry_station).to eq(entry_station)
    end
  end

  describe '#journey_end' do
    it 'shows the end station' do
      expect(journey.journey_end(exit_station)).to eq(exit_station)
    end
  end

  describe '#journey_complete?' do
    it 'shows whether a journey is complete' do
      journey.start_journey(entry_station)
      journey.journey_end(exit_station)
      expect(journey.journey_complete?).to eq(true)
    end

    it 'shows a journey as incomplete if the user hasn\'t touched out' do
      journey.start_journey(entry_station)
      expect(journey.journey_complete?).to eq(false)
    end

    it 'shows a journey as incomplete if the user hasn\'t touched in' do
      journey.journey_end(exit_station)
      expect(journey.journey_complete?).to eq(false)
    end
  end

  describe '#fare' do
    it 'charges a fare for a complete journey' do
      journey.start_journey(entry_station)
      journey.journey_end(exit_station)
      expect(journey.fare).to eq(Journey::MINIMUM_CHARGE)
    end
  end

  describe '#penalty_fare' do
    it 'charges a penalty fare if the user has not touched in' do
      journey.journey_end(exit_station)
      expect(journey.fare).to eq(Journey::PENALTY_FARE)
    end

    it 'charges a penalty fare if the user doesn\'t touch out' do
      journey.start_journey(entry_station)
      expect(journey.fare).to eq(Journey::PENALTY_FARE)
    end

  end

end
