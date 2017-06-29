class CreateUserRequirementItems < ActiveRecord::Migration
  def change
    create_table :user_requirement_items do |t|
      t.belongs_to :user, index: true
      t.belongs_to :requirement_item, index: true
      t.integer :quantity
      t.string :brand
      t.string :description
      t.string :upc
      t.string :asin
      t.string :name

      t.timestamps
    end
  end
end
