class AddRefdatumToHourlies < ActiveRecord::Migration
  def change
    add_reference :hourlies, :ref_datum, index: true
  end
end
