class AddModelYearRequestCount < ActiveRecord::Migration
  def change
    add_column :model_years, :model_year_update_requests_count, :integer, :default => 0
    
    ModelYear.reset_column_information
    ModelYear.all.each do |model_year|
      ModelYear.update_counters model_year.id, :model_year_update_requests_count => model_year.model_year_update_requests.length
    end
  end
end
