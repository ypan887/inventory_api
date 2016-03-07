class Supply < ActiveRecord::Base
  belongs_to :merchant
  has_many :supply_details
  has_many :product, :throgh => :supply_details

  validates :order_date, presence: true
end
