class ModelYearServiceRequirement < ActiveRecord::Base
  # Associations
  belongs_to :requirement_item
  belongs_to :model_year_service
  belongs_to :requirement_category
  has_many   :model_year_service_requirement_votes
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
  belongs_to :replaced, class_name: 'ModelYearServiceRequirement'
  belongs_to :replaced_by, class_name: 'ModelYearServiceRequirement'
  
  # Validations
  validates_uniqueness_of :requirement_item_id, :scope => [:model_year_service_id, :requirement_category_id, :quantity, :quantity_unit]
  validates :requirement_item_id,  presence: true
  validates :model_year_service_id,  presence: true
  validates :requirement_category_id,  presence: true
end
