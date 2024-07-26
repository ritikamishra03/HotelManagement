require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
    let(:admin) {{admin:true}}
    let(:customer) {create(:user, customer:true)}
    let(:staff){create(:staff, staff:true)}
    let(:room){create(:room)}
    let(:room_type){create(:room_type)}
    let(:booking){create(:booking, user: customer, room: room)}

    # before do
    #     sign_in user
    # end

    describe 'GET #index' do
        context 'when admin' do
            let(:user){admin}
            it 'return all bookings' do
                get :index
                expect(assigns(:booking)).to eq(Booking.all)
            end
        end
    end
end