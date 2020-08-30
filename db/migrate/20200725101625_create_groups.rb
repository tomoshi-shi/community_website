class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups, id: :uuid do |t|
      t.string :name, null: false
      t.date :active_date
      t.date :deactive_date

      t.timestamps
    end
  end
end
