class CreateModelYearUpdateRequests < ActiveRecord::Migration
  def change
    create_table :model_year_update_requests do |t|
      t.belongs_to :user
      t.belongs_to :model_year
      t.boolean :is_guest
      t.string :session_id
      t.string :ip_address
      t.timestamps
    end
    
    add_index :model_year_update_requests, [:user_id], 
              name: 'index_myur_on_user_id'
    add_index :model_year_update_requests, [:model_year_id], 
              name: 'index_myur_on_model_year_id'
  end
end
