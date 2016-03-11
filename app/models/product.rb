class Product < ActiveRecord::Base
  belongs_to :category
  has_many :order_details
  has_many :shipment_details
  has_many :supply_details
  has_many :orders, :through => :order_details
  has_many :shipments, :through => :shipment_details
  has_many :supplies, :through => :supply_details
  validates :price, presence: true
  validates :cost, presence: true
  validates :name, presence: true

  # Item supply
end
