class Shipment < ActiveRecord::Base
  has_many :shipment_details
  has_many :products, :through => :shipment_details
  accepts_nested_attributes_for :shipment_details, reject_if: :all_blank, allow_destroy: true

  validates :ship_date, presence: true
end
