class Shipment < ActiveRecord::Base
  validates :ship_date, presence: true
end
