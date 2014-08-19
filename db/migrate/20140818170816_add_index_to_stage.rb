class AddIndexToStage < ActiveRecord::Migration
  def change
    add_index :stages, :code
    add_index :stages, :app_id
  end
end
