class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :country, :zip_code
end
