class CreateProductAttributeValues < ActiveRecord::Migration[5.1]
  def change
    create_table :product_attribute_values do |t|
      t.references :attribute, foreign_key: true
      t.references :attribute_value, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
