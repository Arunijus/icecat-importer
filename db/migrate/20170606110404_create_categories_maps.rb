class CreateCategoriesMaps < ActiveRecord::Migration[5.1]
  def change
    create_table :categories_maps do |t|
      t.references :supplier_category, foreign_key: true
      t.references :seller_category, foreign_key: { to_table: :categories}

      t.timestamps
    end
  end
end
