class CreateCategoryClosures < ActiveRecord::Migration[5.1]
  def change
    create_table :category_closure do |t|
      t.references :ancestor, foreign_key: { to_table: :categories, name: :ancestor}
      t.references :descendant, foreign_key: { to_table: :categories}
      t.integer :depth

      t.timestamps
    end
  end
end
