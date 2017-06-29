class AddIsDeletedIsInactive < ActiveRecord::Migration
  def change
    add_column :model_year_service_requirements, :is_deleted, :boolean, default: false
    add_column :model_year_service_requirements, :is_inactive, :boolean, default: false
  end
end
