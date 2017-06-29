class AddNeedsDetailColumn < ActiveRecord::Migration
  def change
    add_column :model_year_service_requirements, :needs_detail , :boolean, default: false
    add_column :requirement_items, :needs_detail, :boolean, default: false
    
    add_column :model_year_service_requirements, :needs_quantity, :boolean, default: false
    add_column :requirement_items, :needs_quantity, :boolean, default: false
  end
end
