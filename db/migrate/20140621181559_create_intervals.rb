class CreateIntervals < ActiveRecord::Migration
  def up
    create_table :intervals do |t|
      t.integer :first_service_miles
      t.integer :interval_miles
      t.integer :interval_months
      t.boolean :is_inactive, default: false
      t.boolean :is_deleted, default: false
      t.integer :created_by_id
      t.integer :updated_by_id
      t.integer :replaced_id
      t.integer :replaced_by_id

      t.timestamps
    end
    
    remove_column :model_year_services, :first_service_miles
    remove_column :model_year_services, :interval_miles
    remove_column :model_year_services, :interval_months
    
    add_column    :model_year_services, :interval_id, :integer, index: true
  end
  
  def down
    add_column :model_year_services, :first_service_miles, :integer
    add_column :model_year_services, :interval_miles, :integer
    add_column :model_year_services, :interval_months, :integer
    remove_column :model_year_services, :interval_id
    drop_table :intervals
  end
end
