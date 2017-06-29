class CreateRequirementCategories < ActiveRecord::Migration
  def change
    create_table :requirement_categories do |t|
      t.string :name
      t.text   :description

      t.timestamps
    end
    add_index :requirement_categories, [:name], :unique => true
  end
end
