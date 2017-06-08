class CreateAttributeValues < ActiveRecord::Migration[5.1]
  def change
    create_table :attribute_values do |t|
      t.references :attribute, foreign_key: true
      t.string :identifier

      t.timestamps
    end
  end
end
