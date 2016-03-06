class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :cost, :description, :category
end
