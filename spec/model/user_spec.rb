require 'rails_helper'

RSpec.describe User, type: :model do
    it 'has a valid factory' do
        expect(FactoryBot.build(:user)).to be_valid
    end

    it 'valid with valid attributes' do
        user=FactoryBot.build(:user)
        expect(user).to be_valid
    end

    it 'is invalid without name' do
        user=FactoryBot.build(:user,name:nil)
        expect(user).to_not be_valid
    end

    it 'is invalid without email' do
        user=FactoryBot.build(:user,email:nil)
        expect(user).to_not be_valid
    end

   
end