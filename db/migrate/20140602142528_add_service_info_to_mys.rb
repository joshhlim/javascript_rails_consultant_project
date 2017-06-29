class AddServiceInfoToMys < ActiveRecord::Migration
  def up
    add_column :model_year_services, :first_service_miles, :integer
  end
  
  def down
    remove_column :model_year_services, :first_service_miles
  end
end
