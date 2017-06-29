class AddIntervalToVotes < ActiveRecord::Migration
  def change
    change_table :votes do |t|
      t.belongs_to :interval, index: true
    end
  end
end
