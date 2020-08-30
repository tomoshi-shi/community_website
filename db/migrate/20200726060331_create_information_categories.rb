class CreateInformationCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :information_categories, id: :uuid do |t|
      t.uuid :group_id
      t.string :name, null: false

      t.timestamps
    end

    add_foreign_key :information_categories, :groups
    add_index :information_categories, :group_id
  end
end
