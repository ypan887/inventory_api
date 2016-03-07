class Product < ActiveRecord::Base
  belongs_to :category
  has_many :order_details
  has_many :orders, :through => :order_details
  validates :price, presence: true
  validates :cost, presence: true
  validates :name, presence: true
end
