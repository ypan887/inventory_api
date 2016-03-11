class Shipment < ActiveRecord::Base
  has_many :shipment_details
  has_many :products, through: :shipment_details
  accepts_nested_attributes_for :shipment_details, reject_if: :all_blank, allow_destroy: true
  validates :ship_date, presence: true

  after_save :create_or_update_cost_of_shipment_this_month

  def self.monthly_cost_of_shipments(year, month)
    month = sprintf '%02d', (1..12) === month.to_i ? month : Date::MONTHNAMES.index(month.capitalize)
    current_month_shipment_costs = Shipment.where("strftime('%y%m', ship_date) = ?", year.to_s + month).inject(0){ |sum, s| sum + s.ship_cost}
  end

  def create_or_update_cost_of_shipment_this_month
    time = self.ship_date.strftime('%y-%m')
    year_month = time.split('-')
    new_ship_cost = Shipment.monthly_cost_of_shipments(year_month.first, year_month.last)
    statement = Statement.where(year_month: time).first_or_create
    statement.shipping_cost = new_ship_cost
    statement.profit = statement.total_monthly_profit
  end
end