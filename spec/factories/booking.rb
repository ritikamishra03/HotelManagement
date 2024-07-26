FactoryBot.define do
    factory :booking do
      room
      user
      check_in { 1.day.from_now }
      check_out { 2.days.from_now }
    end
  end
  