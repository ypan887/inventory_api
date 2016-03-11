class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.float :profit, default: 0
      t.float :income, default: 0
      t.float :shipping_cost, default: 0
      t.float :product_cost, default: 0
      t.string :year_month

      t.timestamps null: false
    end
  end
end
