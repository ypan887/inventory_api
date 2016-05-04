class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :products
end
