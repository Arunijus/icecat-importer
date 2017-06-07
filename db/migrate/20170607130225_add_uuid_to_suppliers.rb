class AddUuidToSuppliers < ActiveRecord::Migration[5.1]
  def change
    add_column :suppliers, :uuid, :string
  end
end
