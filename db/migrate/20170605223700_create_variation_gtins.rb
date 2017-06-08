class CreateVariationGtins < ActiveRecord::Migration[5.1]
  def change
    create_table :variation_gtins do |t|
      t.string :value
      t.string :short_value
      t.references :variation, foreign_key: true

      t.timestamps
    end
  end
end
