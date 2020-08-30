class CreateLinkCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :link_categories, id: :uuid do |t|
      t.string :name
      t.integer :disp_order

      t.timestamps
    end
  end
end
