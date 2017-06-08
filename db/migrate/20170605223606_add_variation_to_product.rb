class AddVariationToProduct < ActiveRecord::Migration[5.1]
  def change
    add_reference :products, :default_variation, foreign_key: { to_table: :variations }
  end
end