class CreateCategoryClosures < ActiveRecord::Migration[5.1]
  def change
    create_table :category_closures do |t|
      t.integer :ancestor
      t.integer :descendant
      t.integer :depth

      t.timestamps
    end
  end
end
