class StatementSerializer < ActiveModel::Serializer
  attributes :id, :income, :shipping_cost, :product_cost, :profit, :year_month
end
