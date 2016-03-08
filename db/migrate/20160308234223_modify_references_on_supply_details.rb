class ModifyReferencesOnSupplyDetails < ActiveRecord::Migration
  def change
    rename_column :supply_details, :products_id, :product_id
    rename_column :supply_details, :supplies_id, :supply_id
  end
end
