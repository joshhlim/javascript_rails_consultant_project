class RequirementCategory < ActiveRecord::Base
  # Associations
  has_many :requirement_items, -> { order(name: :asc) }
  has_many :model_year_service_requirements
  
  # Validations
  validates_uniqueness_of :name
  validates :name,  presence: true
end
