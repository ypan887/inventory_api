class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.string :tracking_number
      t.date :ship_date
      t.float :ship_cost

      t.timestamps null: false
    end
  end
end
