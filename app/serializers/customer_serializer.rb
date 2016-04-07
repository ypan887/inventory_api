class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :country, :zip_code, :photo_id
end
