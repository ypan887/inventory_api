class Category < ActiveRecord::Base
  before_save :capitalize_name
  validates :name, presence: true

  def capitalize_name
    self.name= self.name.capitalize
  end
end

