class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.integer :parent_id
      t.text :name, limit: 255
      t.boolean :is_visible
      t.text :foreign_id, limit: 100
      t.text :slug, limit: 500
      t.integer :depth
      t.text :identifier, limit: 255
      t.integer :priority
      t.text :description, limit: 65535
      t.text :display_rule, limit: 255
      t.integer :family_id

      t.timestamps
    end
  end
end
