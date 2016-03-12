class Product < ActiveRecord::Base
  belongs_to :category
  has_many :order_details
  has_many :shipment_details
  has_many :supply_details
  has_many :orders, :through => :order_details
  has_many :shipments, :through => :shipment_details
  has_many :supplies, :through => :supply_details
  validates :price, presence: true
  validates :cost, presence: true
  validates :name, presence: true

  after_update :update_product_cost_and_profit
  after_update :update_income_and_profit

  def update_product_cost_and_profit
    Statement.where("year_month <= ?", self.created_at.strftime('%Y-%m')).each do |s|
      time = s.year_month.split("-") 
      new_cost = Supply.monthly_cost_of_goods(time.first, time.last)
      s.update( product_cost: new_cost)
      s.update( profit: s.total_monthly_profit)
    end if self.cost_changed?
  end

  def update_income_and_profit
    Statement.where("year_month <= ?", self.created_at.strftime("%Y-%m")).each do |s|
      time = s.year_month.split("-") 
      new_income = Order.monthly_income_of_goods(time.first, time.last)     
      s.update( income: new_income)
      s.update( profit: s.total_monthly_profit)
    end
  end
end
