class AddCbyUbyIsdIsiToRi < ActiveRecord::Migration
  def change
    add_column :requirement_items, :created_by_id, :integer
    add_column :requirement_items, :updated_by_id, :integer
    
    add_column :requirement_items, :is_deleted, :boolean, default: false
    add_column :requirement_items, :is_inactive, :boolean, default: false
  end
end
