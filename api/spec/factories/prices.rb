FactoryGirl.define do
  factory :price do
    price_usd 1.99
    price_type "rent"
    valid_days Faker::Number.non_zero_digit
  end
end
