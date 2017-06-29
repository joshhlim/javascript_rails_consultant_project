class CreateModelYearServiceVideos < ActiveRecord::Migration
  def change
    create_table :model_year_service_videos do |t|
      t.belongs_to :model_year_service, index: true
      t.belongs_to :video, index: true

      t.timestamps
    end
  end
end
