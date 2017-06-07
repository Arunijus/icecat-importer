class CreateAttributeValues < ActiveRecord::Migration[5.1]
  def change
    create_table :attribute_values do |t|
      t.references :attribute, foreign_key: true
      t.string :identifier

      t.timestamps
    end

    create_table :attribute_value_translation do |t|
      t.references :translatable, foreign_key: { to_table: :attribute_values }
      t.string :locale
      t.string :attr_value
      t.string :status
      t.string :hash
    end
  end
end
