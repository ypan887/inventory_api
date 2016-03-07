class SupplyDetail < ActiveRecord::Base
  belongs_to :supplies
  belongs_to :products
end
