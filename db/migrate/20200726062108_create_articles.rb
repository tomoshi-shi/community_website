class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles, id: :uuid do |t|
      t.uuid :article_series_id, null: false
      t.string :title, null: false
      t.text :sentence
      t.integer :publish_status, null:false
      t.timestamp :published_at

      t.timestamps
    end

    add_foreign_key :articles, :article_series
    add_index :articles, :article_series_id
    add_index :articles, :publish_status
  end
end
