class CreateProductFamilies < ActiveRecord::Migration[5.1]
  def change
    create_table :product_families do |t|
      t.string :name
      t.string :uuid
      t.boolean :is_approved

      t.timestamps
    end
  end
end
