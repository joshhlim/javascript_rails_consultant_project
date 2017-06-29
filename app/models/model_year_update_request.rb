class ModelYearUpdateRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :model_year, :counter_cache => true
  
  # Validations
  # For a user, validate that record is unique by user_id and my_id, for guest, validate
  # uniqueness on ip_address and my_id
  validates_uniqueness_of :user_id, :scope => [:model_year_id], if: "!user_id.blank?"
  validates_uniqueness_of :ip_address, :scope => [:model_year_id], if: "user_id.blank?"
  validates_uniqueness_of :session_id, :scope => [:model_year_id], if: "user_id.blank?"
end
