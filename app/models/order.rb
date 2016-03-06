class Order < ActiveRecord::Base
  belongs_to :customer
  validates :order_date, presence: true
end
