class CreateUserGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :user_groups, id: :uuid do |t|
      t.bigint :user_id, null: false
      t.uuid :group_id, null: false
      t.integer :belonging_type, null:false
      t.date :start_date
      t.date :end_date

      t.timestamps
    end

    add_foreign_key :user_groups, :users
    add_foreign_key :user_groups, :groups
    add_index :user_groups, :user_id
    add_index :user_groups, :group_id
    add_index :user_groups, :belonging_type
  end
end
