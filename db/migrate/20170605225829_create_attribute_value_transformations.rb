class CreateAttributeValueTransformations < ActiveRecord::Migration[5.1]
  def change
    create_table :attribute_value_transformations do |t|
      t.references :attribute, foreign_key: true
      t.text :from_value
      t.text :to_value
      t.boolean :is_enabled
      t.string :locale, limit: 2

      t.timestamps
    end
  end
end
