class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.text :description
      t.boolean :complete, default: false

      t.timestamps null: false
    end
  end
end