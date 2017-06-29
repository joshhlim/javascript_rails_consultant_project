class ModelYearServiceSpecification < ActiveRecord::Base
  belongs_to :model_year_service
  belongs_to :specification
  has_one    :specification_category, through: :specification
  has_many   :votes
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
  belongs_to :replaced, class_name: 'ModelYearServiceSpecification'
  belongs_to :replaced_by, class_name: 'ModelYearServiceSpecification'
  
  validates_uniqueness_of :model_year_service_id, :scope => [:specification_id]
  validates_presence_of   :model_year_service_id
  validates_presence_of   :specification_id
end
