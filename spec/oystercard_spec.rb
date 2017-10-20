require 'oystercard'

describe Oystercard do
  let(:oyster) { Oystercard.new }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }


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
        oyster.top_up(10)
        oyster.touch_in(entry_station)
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
        oyster.touch_in(entry_station)
      end

      it "deducts the minimum fare from the card" do
        oyster.touch_out(exit_station)
        expect(oyster.balance).to eq(9)
      end

    end
  end

  describe '#deduct penalty fare' do
    let(:entry_station) {double :entry_station, name: "Aldgate East", zone: 1 }
    it 'deducts a penalty fare if the user has not touched out' do
      oyster.top_up(20)
      oyster.touch_in(entry_station)
      oyster.touch_in(entry_station)
      oyster.touch_out(exit_station)
      expect(oyster.balance).to eq(13)
    end
  end

    it 'deducts a penalty fare if the user has not touched in' do
      oyster.top_up(20)
      oyster.touch_out(exit_station)
      expect(oyster.balance).to eq(14)
    end


end
