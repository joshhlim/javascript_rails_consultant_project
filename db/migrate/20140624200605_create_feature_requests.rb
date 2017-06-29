class CreateFeatureRequests < ActiveRecord::Migration
  def change
    create_table :feature_requests do |t|
      t.belongs_to :feature, index: true
      t.belongs_to :user, index: true
      t.boolean :is_guest
      t.string :ip_address
      t.string :session_id

      t.timestamps
    end
  end
end
