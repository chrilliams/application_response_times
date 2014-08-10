class CreateRefData < ActiveRecord::Migration
  def change
    create_table :ref_data do |t|
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end
