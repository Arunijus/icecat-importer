class CreateCategoriesMap < ActiveRecord::Migration[5.1]
  def change
    create_table :categories_map do |t|
      t.references :supplier_category, foreign_key: true
      t.references :seller_category, foreign_key: { to_table: :categories}

      t.timestamps
    end
  end
end
