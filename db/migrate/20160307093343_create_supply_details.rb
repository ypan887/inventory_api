class CreateSupplyDetails < ActiveRecord::Migration
  def change
    create_table :supply_details do |t|
      t.integer :quantity
      t.references :supplies, index: true, foreign_key: true
      t.references :products, index: true, foreign_key: true
      t.boolean :deliver_check, default: false

      t.timestamps null: false
    end
  end
end
