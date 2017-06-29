class CreateSpecificationCategories < ActiveRecord::Migration
  def change
    create_table :specification_categories do |t|
      t.string :name
      t.text :description
      t.boolean :is_quick_spec, default: false

      t.timestamps
    end
  end
end
