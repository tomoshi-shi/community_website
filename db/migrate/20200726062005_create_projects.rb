class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects, id: :uuid do |t|
      t.uuid :group_id
      t.uuid :parent_id
      t.string :name, null: false
      t.string :summary
      t.date :start_date
      t.date :end_date
      t.boolean :closed, default: false

      t.timestamps
    end

    add_foreign_key :projects, :groups
    add_foreign_key :projects, :projects, column: :parent_id
    add_index :projects, :group_id
    add_index :projects, :parent_id
  end
end
  