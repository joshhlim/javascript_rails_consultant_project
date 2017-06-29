class Interval < ActiveRecord::Base
  has_one  :model_year_service
  has_many :votes
  
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
  belongs_to :replaced, class_name: 'Interval'
  belongs_to :replaced_by, class_name: 'Interval'
end
