class Feature < ActiveRecord::Base
  has_many :feature_requests
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
