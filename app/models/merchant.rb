class Merchant < ActiveRecord::Base
  has_many :supplies
  validates :name, presence: true, allow_blank: false
end
