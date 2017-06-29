class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :url
      t.string :external_source
      t.string :external_id
      t.string :etag
      t.string :title
      t.string :description
      t.string :thumbnail_default_url
      t.text :notes

      t.timestamps
    end
  end
end
