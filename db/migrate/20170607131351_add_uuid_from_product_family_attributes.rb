class AddUuidFromProductFamilyAttributes < ActiveRecord::Migration[5.1]
  def change
    add_column :product_family_attributes, :uuid, :string
  end
end
