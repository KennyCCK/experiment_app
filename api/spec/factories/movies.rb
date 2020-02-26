FactoryGirl.define do
  factory :movie do
    movie_name Faker::Movie.name
    movie_desc Faker::Movie.quote
  end
end
