class UserRequirementItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :requirement_item
  
  validates_presence_of :user
  validates_presence_of :requirement_item
end
