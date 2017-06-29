class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.string :description
      t.integer :popularity
      t.string :video_url

      t.timestamps
    end
    add_index :services, :name, unique: true
  end
end
