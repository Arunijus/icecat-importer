class CreateProductLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :product_links do |t|
      t.references :product, foreign_key: true
      t.string :title
      t.string :url
      t.string :resource_id
      t.string :link_type
      t.boolean :is_active
      t.integer :position
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
