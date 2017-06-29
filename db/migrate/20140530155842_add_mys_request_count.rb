class AddMysRequestCount < ActiveRecord::Migration
  def change
    add_column :model_year_services, :model_year_service_update_requests_count, :integer, :default => 0
    remove_column :model_year_services, :request_count
    
    ModelYearService.reset_column_information
    ModelYearService.all.each do |mys|
      ModelYearService.update_counters mys.id, :model_year_service_update_requests_count => mys.model_year_service_update_requests.length
    end
  end
end
