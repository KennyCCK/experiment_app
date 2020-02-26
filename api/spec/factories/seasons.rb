FactoryGirl.define do
  factory :season do
    season_num Faker::Number.non_zero_digit
    season_title Faker::Vehicle
    season_synopsis Faker::Book.title
  end
end
