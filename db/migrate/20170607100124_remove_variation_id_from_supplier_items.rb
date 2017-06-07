class RemoveVariationIdFromSupplierItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :supplier_items, :variation_id, :integer
  end
end
