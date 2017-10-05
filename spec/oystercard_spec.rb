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
      subject.top_up(maximum_balance)
      expect{ subject.top_up(1)}.to raise_error 'Maximum balance exceeded'
    end

  end

  describe '#deduct' do

    it 'can deduct money from the balance' do

      expect { subject.deduct(1) }.to change{ subject.balance }.by(-1)
    end

  end



    describe '#touch_in' do

      it "touches the user in and marks as on_journey" do
        oyster.touch_in
        expect(oyster.in_use).to be(true)
      end

    end

    describe '#touch_out' do

      it "touches the user out and marks as not on_journey" do
        oyster.touch_out
        expect(oyster.in_use).to be(false)
      end

    end

end
