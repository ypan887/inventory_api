class Customer < ActiveRecord::Base
  validates :name, presence: true, allow_blank: false
  has_many :orders
end
