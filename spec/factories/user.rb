FactoryBot.define do
    factory :user do
      sequence(:email) { |n| "user#{n}@example.com" }
      password { 'password' }
      role {"customer"}
      name {"xyz"}
    end
  end