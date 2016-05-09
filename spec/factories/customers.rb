FactoryGirl.define do
  factory :customer do
    name { Faker::Name.name }
    address { Faker::Address.street_address }
    country { Faker::Address.country }
    zip_code { Faker::Address.zip }
  end
end
