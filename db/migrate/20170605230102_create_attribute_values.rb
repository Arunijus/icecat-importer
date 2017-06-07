class CreateAttributeValues < ActiveRecord::Migration[5.1]
  def change
    create_table :attribute_values do |t|
      t.references :attribute, foreign_key: true
      t.string :identifier

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        AttributeValue.create_translation_table! :attr_value => :text, :status => :string, :hash => :string
      end

      dir.down do
        AttributeValue.drop_translation_table!
      end
    end
  end
end
