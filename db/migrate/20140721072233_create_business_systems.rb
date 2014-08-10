class CreateBusinessSystems < ActiveRecord::Migration
  def change
    create_table :business_systems do |t|
      t.string :business_service_name
      t.integer :metric_id
      t.decimal :current_sla_kpi
      t.decimal :target

      t.timestamps
    end
  end
end
