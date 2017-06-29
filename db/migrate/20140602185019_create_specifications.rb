class CreateSpecifications < ActiveRecord::Migration
  def change
    create_table :specifications do |t|
      t.belongs_to :model_year, index: true
      t.belongs_to :specification_category, index:true
      t.string :single_value_str
      t.string :range_start_str
      t.string :range_end_str
      t.boolean :is_quick_spec, default: false

      t.timestamps
    end
  end
end
