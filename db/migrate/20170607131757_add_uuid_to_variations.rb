class AddUuidToVariations < ActiveRecord::Migration[5.1]
  def change
    add_column :variations, :uuid, :string
  end
end
