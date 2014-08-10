class AddRefDatumTo < ActiveRecord::Migration
  def change
    add_reference :events, :ref_datum, index: true
  end
end
