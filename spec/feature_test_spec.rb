require './lib/oystercard'
require './lib/journey'
require './lib/station'

oystercard = Oystercard.new
journey = Journey.new
station = Station.new("Aldgate East", 1)

oystercard.top_up(20)

journey.start_journey(station)
journey.journey_end("Victoria")

journey.fare


# # tests for edge case: no touch out
# p oystercard.top_up(10)
# p oystercard.touch_in(station)
# p oystercard.touch_in(station)
# p oystercard.balance
#


# # # # # In order to use public transport
# # # # # As a customer
# # # # # I want money on my card
# # # #
# oyster = Oystercard.new
# # # #
# # # # oyster.money?
# # #
# # #
# # oyster = Oystercard.new
# # # oyster.add_money(50)
# # describe Oystercard do
# # let(:oyster) {described_class.new}
# #   it 'raises an error if new balance exceeds limit' do
# #     expect{oyster.top_up(100)}.to raise_error("The balance has exceeded the #{oyster.limit}")
# #   end
# #
# # puts oyster.limit
# # end
# describe Oystercard do
#   let(:oyster) {Oystercard.new}
#   # it "checks if the person is on a journey" do
#   #   expect(oyster).to be_on_journey
#   # end
#
#   it "touches in the user" do
#     expect(oyster).to respond_to(:touch_in)
#   end
#
#   it "touches the user in and marks as on_journey" do
#     expect(oyster).to receive(:touch_in).and change(oyster.on_journey?).to(true)
#   end
#
# end
