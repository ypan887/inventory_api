FactoryGirl.define do
  factory :shipment_detail do
    shipment
    quantity 1

    after(:build) do |detail|
      detail.product_id = FactoryGirl.create(:product)
    end
  end
end