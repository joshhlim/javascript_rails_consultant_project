class AddIsaIsdUbyCbyToSpecification < ActiveRecord::Migration
  def change
    add_column :specifications, :created_by_id, :integer
    add_column :specifications, :updated_by_id, :integer
    add_column :specification_categories, :created_by_id, :integer
    add_column :specification_categories, :updated_by_id, :integer
    add_column :model_year_service_specifications, :created_by_id, :integer
    add_column :model_year_service_specifications, :updated_by_id, :integer
    
    add_column :specifications, :is_deleted, :boolean, default: false
    add_column :specifications, :is_inactive, :boolean, default: false
    add_column :specification_categories, :is_deleted, :boolean, default: false
    add_column :specification_categories, :is_inactive, :boolean, default: false
    add_column :model_year_service_specifications, :is_deleted, :boolean, default: false
    add_column :model_year_service_specifications, :is_inactive, :boolean, default: false
  end
end
