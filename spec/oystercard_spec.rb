require 'oystercard'

describe Oystercard do
  let(:oyster) { Oystercard.new(0) }
  it 'has money on the card' do
    expect(oyster.balance).to eq(0)
  end

  it 'adds money to balance' do
    oyster.add_money(50)
    expect(oyster.balance).to eq(50)
  end


end
