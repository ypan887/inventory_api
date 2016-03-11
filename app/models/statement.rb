class Statement < ActiveRecord::Base
  def total_monthly_profit
    profit = income - shipping_cost - product_cost
  end  
end
