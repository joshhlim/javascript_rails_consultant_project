class CreateModelYearServiceSpecifications < ActiveRecord::Migration
  def change
    create_table :model_year_service_specifications do |t|
      t.belongs_to :model_year_service
      t.belongs_to :specification

      t.timestamps
    end
    
    add_index :model_year_service_specifications, 
              [:model_year_service_id, :specification_id], 
              :unique => true, 
              name: 'index_model_year_service_specifications_unique'
    add_index :model_year_service_specifications, :model_year_service_id, 
              name: 'index_myss_on_mys_id'
    add_index :model_year_service_specifications, :specification_id, 
              name: 'index_myss_on_specification_id'
  end
end
