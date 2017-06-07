class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :uuid
      t.text :note
      t.datetime :exported_at
      t.integer :default_variation_id
      t.references :family, foreign_key: { to_table: :product_families }

      t.timestamps
    end
  end
end
