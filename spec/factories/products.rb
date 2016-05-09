FactoryGirl.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price 1.5
    cost 1.5
    description { Faker::Lorem.sentence }
    category
  end
end
