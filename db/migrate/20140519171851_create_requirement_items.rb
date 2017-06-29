class CreateRequirementItems < ActiveRecord::Migration
  def change
    create_table :requirement_items do |t|
      t.string :name
      t.string :detail
      t.text :description
      t.text :link_for_sale
      t.text :link_for_img
      t.integer :substitute_requirement_item_id
      t.references :requirement_category, index: true

      t.timestamps
    end
    add_index :requirement_items, [:requirement_category_id, :name, :detail], :unique => true, name: 'index_requirement_items_unique'
  end
end
