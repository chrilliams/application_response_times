class CreateJoinTableBusinessSystemRefDatum < ActiveRecord::Migration
  def change
    add_reference :ref_data, :business_system, index: true
  end
end
