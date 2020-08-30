class CreateArticleSeries < ActiveRecord::Migration[5.2]
  def change
    create_table :article_series, id: :uuid do |t|
      t.string :name, null: false
      t.string :summary, null: false
      t.integer :publish_status, null:false

      t.timestamps
    end
  end
end
