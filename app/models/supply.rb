class Supply < ActiveRecord::Base
  belongs_to :merchant
  has_many :supply_details
  has_many :products, :through => :supply_details
  accepts_nested_attributes_for :supply_details, reject_if: :all_blank, allow_destroy: true
  validates :order_date, presence: true

  after_save :create_or_update_cost_of_goods_this_month

  def self.monthly_cost_of_goods(year, month)
    month = sprintf '%02d', (1..12) === month.to_i ? month : Date::MONTHNAMES.index(month.capitalize)
    current_month_supplies = Supply.where("strftime('%Y%m', order_date) = ?", year.to_s + month).joins(:supply_details, :products).uniq
    current_month_supplies.inject(0) do |sum, hash|
      h1 = hash.supply_details.pluck(:product_id, :quantity).to_h
      h2 = hash.products.pluck(:id, :cost).to_h
      keys = h1.keys
      supply_cost = keys.inject(0){ |sum, k| sum + h1[k] * h2[k]}
      sum + supply_cost
    end
  end

  def create_or_update_cost_of_goods_this_month
    time = self.order_date.strftime('%Y-%m')
    year_month = time.split('-')
    new_cost = Supply.monthly_cost_of_goods(year_month.first, year_month.last)
    statement = Statement.where(year_month: time).first_or_create
    statement.update( product_cost: new_cost)
    statement.update( profit: statement.total_monthly_profit)
  end
end