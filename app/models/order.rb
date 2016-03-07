class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :order_details
  has_many :products, :through => :order_details
  validates :order_date, presence: true

  accepts_nested_attributes_for :order_details, reject_if: :all_blank, allow_destroy: true
end
