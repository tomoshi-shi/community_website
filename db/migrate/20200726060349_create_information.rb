class CreateInformation < ActiveRecord::Migration[5.2]
  def change
    create_table :information, id: :uuid do |t|
      t.uuid :information_category_id, null: false
      t.string :title, null: false
      t.string :scentence
      t.integer :publish_status, null:false
      t.timestamp :published_at

      t.timestamps
    end

    add_foreign_key :information, :information_categories
    add_index :information, :information_category_id
    add_index :information, :publish_status
  end
end
