require 'oystercard'

describe Oystercard do
  let(:oyster) { Oystercard.new }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  describe '#balance' do
    context 'there is balance' do
      before do
        allow(oyster).to receive(:balance).and_return(10)
      end
      it 'has money on the card' do
        current_balance = 10
        expect(oyster.balance).to eq(current_balance)
      end
    end
  end

  describe '#top_up tests' do
    context 'not yet topped up' do
      it 'can top up the balance' do
        expect{ oyster.top_up(1) }.to change{ oyster.balance }.by(1)
      end
    end
    context 'already topped up' do
      it 'raises an error if the maximum balance is exceeded' do
        maximum_balance = Oystercard::MAXIMUM_BALANCE
        oyster.top_up(maximum_balance)
        oyster.balance
        expect{ oyster.top_up(1) }.to raise_error("Maximum balance exceeded")
      end
    end
  end

  describe '#deduct test' do
    it 'can deduct money from the balance' do
      expect { oyster.deduct(1) }.to change{ oyster.balance }.by(-1)
    end
  end


  describe '#touch_in test' do
    context 'topped up' do
      before do
        allow(oyster).to receive(:balance).and_return(10)
      end
      it "touches the user in and marks as on_journey" do
        oyster.balance = 10
        oyster.touch_in(entry_station)
        expect(oyster.in_journey?).to be(true)
      end
      it "remembers the entry station after touch in" do
        oyster.balance = 10
        oyster.touch_in(entry_station)
        expect(oyster.entry_station).to eq(entry_station)
      end
    end

    context 'not topped up' do
      before do
        allow(oyster).to receive(:balance).and_return(0)
      end
      it "raises an error if the user doesn't touch in" do
        expect { oyster.touch_in(entry_station)}.to raise_error("Insufficient balance to touch in")
      end
    end
  end



  describe '#touch_out tests' do
    context 'topped up' do
      before do
        oyster.top_up(10)
      end
      it "touches the user out and marks as not on_journey" do
        oyster.touch_out(exit_station)
        expect(oyster.in_journey?).to be(false)
      end
      it "deducts the minimum fare from the card" do
        expect{oyster.touch_out(exit_station)}.to change{oyster.balance}.by(-Oystercard::MINIMUM_CHARGE)
      end
      it "stores the exit station" do
        oyster.touch_in(entry_station)
        oyster.touch_out(exit_station)
        expect(oyster.exit_station).to eq(exit_station)
      end
    end
  end

  describe '#journeys' do

    it 'has an empty list of journeys' do
      #expect(oyster.journeys).to be([])
      expect(oyster.journeys).to be_empty
    end
  end

  describe '#journey' do

    let(:journey) { {entry_station:  entry_station, exit_station: exit_station} }
    before do
      oyster.top_up(10)
    end
    it 'stores a journey' do

      oyster.touch_in(entry_station)
      oyster.touch_out(exit_station)
      expect(oyster.journey).to eq(journey)

    end
  end

end
