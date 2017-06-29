class Specification < ActiveRecord::Base
  belongs_to :model_year
  belongs_to :specification_category
  has_many :votes
  has_many :model_year_services, through: :model_year_service_specifications
  has_many :model_year_service_specifications
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
  belongs_to :replaced, class_name: 'Specification'
  belongs_to :replaced_by, class_name: 'Specification'
  
  #Validations
  validates_presence_of :model_year_id
  validates_presence_of :specification_category_id
  #Must have a start and end to a range
  validates :range_start_str, presence: true, if: "!range_end_str.blank?"
  validates :range_end_str, presence: true, if: "!range_start_str.blank?"
  #Must have a single value if no range
  validates :single_value_str, presence: true, if: "range_start_str.blank? && range_end_str.blank?"
end
