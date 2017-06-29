class SpecificationCategory < ActiveRecord::Base
  has_many :specifications
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
  belongs_to :replaced, class_name: 'SpecificationCategory'
  belongs_to :replaced_by, class_name: 'SpecificationCategory'
  
  validates_uniqueness_of :name
  validates :name, presence: true
end
