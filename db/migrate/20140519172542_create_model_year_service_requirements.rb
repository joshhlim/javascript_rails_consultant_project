class CreateModelYearServiceRequirements < ActiveRecord::Migration
  def change
    create_table :model_year_service_requirements do |t|
      t.references :requirement_item, index: true
      t.references :model_year_service, index: true
      t.references :requirement_category
      t.integer :quantity
      t.string  :quantity_unit
      t.integer :user_confirmations
      t.integer :visitor_confirmations
      t.integer :user_rejections
      t.integer :visitor_rejections
      t.integer :user_optionals
      t.integer :visitor_optionals
      t.text :notes
      t.integer :substitute_requirement_item_id
      t.integer :net_confirmations

      t.timestamps
    end
    
    add_index :model_year_service_requirements, 
              [:model_year_service_id, :requirement_category_id, :requirement_item_id], 
              :unique => true, 
              name: 'index_model_year_service_requirements_unique'
              
    add_index :model_year_service_requirements, [:requirement_category_id], 
              name: 'index_mysr_on_requirement_category_id'
  end
end
