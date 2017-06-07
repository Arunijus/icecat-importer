class RemoveUuidFromSuppliers < ActiveRecord::Migration[5.1]
  def change
    remove_column :suppliers, :uuid, :string
  end
end
