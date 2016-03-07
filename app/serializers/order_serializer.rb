class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_date
  has_one :customer
  has_many :order_details
end
