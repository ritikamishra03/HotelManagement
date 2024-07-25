FactoryBot.define do
    factory :booking do
      check_in {'2024-08-27'}
      check_out{'2024-08-29'}
      status{'booked'}
      user_id{1}
      room_id{1}
    end
  end