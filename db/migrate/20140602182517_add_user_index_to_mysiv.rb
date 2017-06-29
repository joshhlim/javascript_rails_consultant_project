class AddUserIndexToMysiv < ActiveRecord::Migration
  def change
    add_index :model_year_service_interval_votes, :user_id, 
              name: 'index_mysiv_on_user_id'
  end
end
