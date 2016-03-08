class AddMerchantIdForeignKeyToSupply < ActiveRecord::Migration
  def change
    change_table :supplies do |t|
      t.references :merchant, index: true, foreign_key: true
    end
  end
end
