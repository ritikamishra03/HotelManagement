require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
    let(:booking){FactoryBot.create(:booking)}

    describe "Get" do
        context "Get /Index" do
            let(:admin){User.create(password:"12345678")}
            it "should render index page" do
                get 'index'
                sign_in 
                # expect(response).to render_template :index
            end
        end
    end
end