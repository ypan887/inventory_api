class SupplySerializer < ActiveModel::Serializer
  attributes :id, :order_date
  has_one :merchant
  has_many :supply_details
end
