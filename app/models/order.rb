class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :order_details
  has_many :products, :through => :order_details
  accepts_nested_attributes_for :order_details, reject_if: :all_blank, allow_destroy: true
  validates :order_date, presence: true

  after_save :create_or_update_income_of_goods_this_month


  def self.monthly_income_of_goods(year, month)
    month = sprintf '%02d', (1..12) === month.to_i ? month : Date::MONTHNAMES.index(month.capitalize)
    current_month_sales = Order.where("strftime('%y%m', order_date) = ?", year.to_s + month).joins(:order_details, :products).uniq
    current_month_sales.inject(0) do |sum, hash|
      h1 = hash.order_details.pluck(:product_id, :quantity).to_h
      h2 = hash.products.pluck(:id, :price).to_h
      keys = h1.keys
      order_income = keys.inject(0){ |sum, k| sum + h1[k] * h2[k]}
      sum + order_income
    end
  end

  def create_or_update_income_of_goods_this_month
    time = self.order_date.strftime('%y-%m')
    year_month = time.split('-')
    new_income = Order.monthly_income_of_goods(year_month.first, year_month.last)
    statement = Statement.where(year_month: time).first_or_create
    statement.income = new_income
    statement.profit = statement.total_monthly_profit
  end
end
