class AddActionAndItemToService < ActiveRecord::Migration
  def change
    add_column :services, :action, :string
    add_column :services, :item,   :string
    add_column :services, :item_action_display, :string
    
  end
end
