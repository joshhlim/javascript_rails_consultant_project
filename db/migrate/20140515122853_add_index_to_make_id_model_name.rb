class AddIndexToMakeIdModelName < ActiveRecord::Migration
  def change
    add_index :models, [:make_id, :name], :unique => true
  end
end
