class AddUuidFromAttributeValues < ActiveRecord::Migration[5.1]
  def change
    add_column :attribute_values, :uuid, :string
  end
end
