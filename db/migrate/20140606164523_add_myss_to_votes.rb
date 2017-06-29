class AddMyssToVotes < ActiveRecord::Migration
  def change
    change_table :votes do |t|
      t.belongs_to :model_year_service_specification, index: true
    end
  end
end
