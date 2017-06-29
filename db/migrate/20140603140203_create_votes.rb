class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.belongs_to :specification, index: true
      t.belongs_to :user, index: true
      t.belongs_to :vote_type, index: true
      t.boolean :is_guest
      t.string :ip_address
      t.string :session_id

      t.timestamps
    end
  end
end
