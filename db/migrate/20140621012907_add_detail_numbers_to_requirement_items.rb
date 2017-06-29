class AddDetailNumbersToRequirementItems < ActiveRecord::Migration
  def change
    add_column :requirement_items, :detail_numbers, :integer
    add_column :requirement_items, :detail_characters, :string
    add_column :requirement_items, :detail_downcase_no_whitespace, :string
    
    # There is a new before_save callback to fill in these columns, it will be run on each call to save below
    RequirementItem.all.each do |item|
      if !item.detail.blank?
        item.save
      end
    end
    
  end
  
end
