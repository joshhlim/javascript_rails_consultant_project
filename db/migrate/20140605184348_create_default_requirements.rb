class CreateDefaultRequirements < ActiveRecord::Migration
  def change
    create_table :default_requirements do |t|
      t.belongs_to :service, index: true
      t.belongs_to :requirement_item, index: true

      t.timestamps
    end
    
    add_index :default_requirements, 
              [:service_id, :requirement_item_id], 
              :unique => true, 
              name: 'index_default_service_requirements_unique'
  end
end
