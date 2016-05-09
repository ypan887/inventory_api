class Category < ActiveRecord::Base
  before_save :capitalize_name
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  has_many :products

  def capitalize_name
    self.name= self.name.capitalize
  end
end

