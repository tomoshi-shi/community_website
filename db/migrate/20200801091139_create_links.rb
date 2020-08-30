class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links, id: :uuid do |t|
      t.uuid :link_category_id, null: false
      t.string :name
      t.string :note
      t.text :url
      t.integer :disp_order

      t.timestamps
    end

    add_foreign_key :links, :link_categories
    add_index :links, :link_category_id
  end
end
