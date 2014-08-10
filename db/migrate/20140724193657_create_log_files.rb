class CreateLogFiles < ActiveRecord::Migration
  def change
    create_table :log_files do |t|
      t.string :file_name
      t.string :line_format
      t.string :fields

      t.timestamps
    end
  end
end
