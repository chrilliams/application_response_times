class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :finish_time
      t.integer :duration
      t.string :system
      t.string :sub_system

      t.timestamps
    end
  end
end
