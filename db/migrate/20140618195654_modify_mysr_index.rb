class ModifyMysrIndex < ActiveRecord::Migration
  def up
    remove_index :model_year_service_requirements, name: :index_model_year_service_requirements_unique
    add_index :model_year_service_requirements,
              ["model_year_service_id", "requirement_category_id", "requirement_item_id", "quantity", "quantity_unit"],
              name: :index_model_year_service_requirements_unique
  end
  
  def down
    add_index :model_year_service_requirements, ["model_year_service_id", "requirement_category_id", "requirement_item_id"], name: "index_model_year_service_requirements_unique", unique: true, using: :btree
  end
end
