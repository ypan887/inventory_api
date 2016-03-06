class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :address
      t.string :country
      t.string :zip_code
      t.boolean :photo_id, default: false

      t.timestamps null: false
    end
  end
end
