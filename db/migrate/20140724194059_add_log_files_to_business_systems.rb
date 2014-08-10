class AddLogFilesToBusinessSystems < ActiveRecord::Migration
  def change
    add_reference :log_files, :business_system, index: true
  end
end
