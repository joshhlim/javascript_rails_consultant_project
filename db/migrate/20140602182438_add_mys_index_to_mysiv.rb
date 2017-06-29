class AddMysIndexToMysiv < ActiveRecord::Migration
  def change
    add_index :model_year_service_interval_votes, :model_year_service_id, 
              name: 'index_mysiv_on_mys_id'
  end
end
