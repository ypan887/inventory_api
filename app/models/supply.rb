class Supply < ActiveRecord::Base
  belongs_to :merchant
  has_many :supply_details
  has_many :product, :through => :supply_details
  accepts_nested_attributes_for :supply_details, reject_if: :all_blank, allow_destroy: true

  validates :order_date, presence: true
end
