class ComplexQuery < ActiveRecord::Base
  def self.user_vehicle_services_for_user_requirement_item(user_requirement_item_id)
    query_string = 
      "SELECT  uri.id,
               my.year AS model_year_year,
               ma.name AS make_name,
               mo.name AS model_name,
               uv.id AS user_vehicle_id,
               uv.name AS user_vehicle_name,
               mys.id AS model_year_service_id,
               s.name AS service_name
          FROM user_requirement_items uri
          JOIN requirement_items ri
            ON ri.id = uri.requirement_item_id AND ri.is_inactive = false AND ri.is_deleted = false
          JOIN model_year_service_requirements mysr
            ON mysr.requirement_item_id = ri.id AND mysr.is_inactive = false AND mysr.is_deleted = false
          JOIN model_year_services mys
            ON mysr.model_year_service_id = mys.id
          JOIN services s
            ON mys.service_id = s.id
          JOIN model_years my
            ON mys.model_year_id = my.id
          JOIN models mo
            ON mo.id = my.model_id
          JOIN makes ma
            ON ma.id = mo.make_id
          JOIN user_vehicles uv
            ON uv.model_year_id = my.id AND uv.user_id = uri.user_id
         WHERE uri.id = ?;"
    # Notice how you can, and should, still sanitize params here. 
    self.connection.execute(sanitize_sql([query_string, user_requirement_item_id]))
  end
end