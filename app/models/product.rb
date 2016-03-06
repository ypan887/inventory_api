class Product < ActiveRecord::Base
  belongs_to :category
  validates :price, presence: true
  validates :cost, presence: true
  validates :name, presence: true
end
