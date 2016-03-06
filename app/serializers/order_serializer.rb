class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_date
  has_one :customer
end
