FactoryGirl.define do
  factory :episode do
    episode_num 1
    episode_title Faker::Movie.name
    episode_plot 'no plot'
  end
end
