class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.date :order_date
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
