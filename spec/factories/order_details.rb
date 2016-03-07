FactoryGirl.define do
  factory :order_detail do
    order 
    product
    quantity 1
  end
end
