class AddIndexToMakeName < ActiveRecord::Migration
  def change
    add_index :makes, :name, unique: true
  end
end
