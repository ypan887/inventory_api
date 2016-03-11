class SupplyDetail < ActiveRecord::Base
  belongs_to :supply
  belongs_to :product
end
