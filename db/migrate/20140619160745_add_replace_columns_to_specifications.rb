class AddReplaceColumnsToSpecifications < ActiveRecord::Migration
  def change
    add_column :model_year_service_specifications, :replaced_id, :integer
    add_column :model_year_service_specifications, :replaced_by_id, :integer
    
    add_column :specifications, :replaced_id, :integer
    add_column :specifications, :replaced_by_id, :integer
  end
end
