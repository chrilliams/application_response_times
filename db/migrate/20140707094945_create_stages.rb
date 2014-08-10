class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.datetime :ev_time
      t.string :app_id
      t.string :code
      t.string :description
      t.string :conversation_id
      t.string :system
      t.string :sub_system

      t.timestamps
    end
  end
end
