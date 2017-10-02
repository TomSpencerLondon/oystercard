require 'oystercard'

describe Oystercard do
  let(:oyster) { Oystercard.new(0) }
  it 'has money on the card' do
    expect(oyster.money).to eq(0)
  end
end
