class Statement < ActiveRecord::Base
  def total_monthly_profit
    cost = shipping_cost + product_cost
    profit = income - cost
  end  
end
