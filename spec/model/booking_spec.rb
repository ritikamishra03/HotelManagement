require 'rails_helper'

RSpec.describe Booking, type: :model do
    let(:booking) { FactoryBot.build(:booking)}

    context 'Should validate' do
        it 'with check_in,check_out,status' do
            expect(booking).to be_valid
        end
    end
end