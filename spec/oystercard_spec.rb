require 'oystercard'

describe Oystercard do
  let(:oyster) { Oystercard.new }

  describe '#balance' do
    before do
      allow(oyster).to receive(:balance).and_return(10)
    end

    it 'has money on the card' do
      current_balance = 10
      expect(oyster.balance).to eq(current_balance)
    end

  end

  describe '#top_up' do

    it 'can top up the balance' do
      expect{ subject.top_up(1) }.to change{ subject.balance }.by(1)
    end

    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      oyster.top_up(maximum_balance)
      oyster.balance
      expect{ oyster.top_up(1) }.to raise_error("Maximum balance exceeded")
    end

  end

  describe '#deduct' do

    it 'can deduct money from the balance' do

      expect { subject.deduct(1) }.to change{ subject.balance }.by(-1)
    end

  end



    describe '#touch_in' do
      let(:station) {double :station}
      it "touches the user in and marks as on_journey" do
        oyster.balance = 10
        oyster.touch_in(station)
        expect(oyster.in_journey?).to be(true)
      end

      it "raises an error if the user doesn't touch in" do
        oyster.balance = 0
        expect { oyster.touch_in(station)}.to raise_error("Insufficient balance to touch in")
      end

      it "remembers the entry station after touch in" do
        oyster.balance = 10
        oyster.touch_in(station)
        expect(oyster.entry_station).to eq(station)
      end

    end

    describe '#touch_out' do

      it "touches the user out and marks as not on_journey" do
        oyster.touch_out
        expect(oyster.in_journey?).to be(false)
      end

      it "deducts the minimum fare from the card" do

        expect {oyster.touch_out}.to change{oyster.balance}.by(-Oystercard::MINIMUM_CHARGE)
      end

    end


end
