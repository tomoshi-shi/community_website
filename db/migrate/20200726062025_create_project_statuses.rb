class CreateProjectStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :project_statuses, id: :uuid do |t|
      t.uuid :project_id, null: false
      t.integer :user_id, null: false
      t.string :status, null: false

      t.timestamps
    end

    add_foreign_key :project_statuses, :projects
    add_foreign_key :project_statuses, :users
    add_index :project_statuses, :project_id
    add_index :project_statuses, :user_id
  end
end
