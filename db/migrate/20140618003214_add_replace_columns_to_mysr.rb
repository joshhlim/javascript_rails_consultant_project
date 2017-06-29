class AddReplaceColumnsToMysr < ActiveRecord::Migration
  def change
    add_column :model_year_service_requirements, :replaced_id, :integer
    add_column :model_year_service_requirements, :replaced_by_id, :integer
  end
end
