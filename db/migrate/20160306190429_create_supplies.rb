class CreateSupplies < ActiveRecord::Migration
  def change
    create_table :supplies do |t|
      t.date :order_date

      t.timestamps null: false
    end
  end
end
