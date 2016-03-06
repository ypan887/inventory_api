class Supply < ActiveRecord::Base
  validates :order_date, presence: true
end
