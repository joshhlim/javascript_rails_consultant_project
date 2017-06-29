class DefaultRequirement < ActiveRecord::Base
  belongs_to :service
  belongs_to :requirement_item
  
  # Validations
  validates_uniqueness_of :service_id, :scope => [:requirement_item_id]
  validates :service_id,  presence: true
  validates :requirement_item_id,  presence: true
end
