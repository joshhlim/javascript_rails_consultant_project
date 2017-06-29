class CreateModelYearServices < ActiveRecord::Migration
  def change
    create_table :model_year_services do |t|
      t.belongs_to :model_year
      t.belongs_to :service
      t.integer :touch_count
      t.integer :request_count
      t.integer :view_count
      t.string :video_url
      t.string :mechanic_search_string
      t.string :notes
      t.integer :interval_miles
      t.integer :interval_months

      t.timestamps
    end
  end
end
