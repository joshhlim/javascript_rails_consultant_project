class AddVideoToVotes < ActiveRecord::Migration
  def change
    change_table :votes do |t|
      t.belongs_to :video, index: true
    end
  end
end