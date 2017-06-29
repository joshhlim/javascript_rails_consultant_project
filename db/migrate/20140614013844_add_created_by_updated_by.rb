class AddCreatedByUpdatedBy < ActiveRecord::Migration
  def change
    add_column :model_year_service_requirements, :created_by_id, :integer
    add_column :model_year_service_requirements, :updated_by_id, :integer
  end
end
