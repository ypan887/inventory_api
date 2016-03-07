class ShipmentSerializer < ActiveModel::Serializer
  attributes :id, :tracking_number, :ship_date, :ship_cost
  has_many :shipment_details
end
