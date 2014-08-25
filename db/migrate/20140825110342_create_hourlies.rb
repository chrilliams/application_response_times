class CreateHourlies < ActiveRecord::Migration
  def change
    create_table :hourlies do |t|
      t.datetime :hour
      t.float :maximum
      t.float :minimum
      t.float :average

      t.timestamps
    end
  end
end
