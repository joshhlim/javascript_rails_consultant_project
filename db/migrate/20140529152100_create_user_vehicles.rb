class CreateUserVehicles < ActiveRecord::Migration
  def change
    create_table :user_vehicles do |t|
      t.references :model_year, index: true
      t.belongs_to :user, index: true
      t.string :name
      t.integer :mileage
      t.string :image_url
      t.string :video_url
      t.integer :privacy_id
      t.integer :rating
      t.integer :views
      t.integer :touches

      t.timestamps
    end
  end
end
