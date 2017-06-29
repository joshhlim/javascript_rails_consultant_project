class ModelYearServiceIntervalVote < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :vote_type
  belongs_to :model_year_service

  # Validations
  # For a user, validate that record is unique by user_id and mysr_id, for guest, validate
  # uniqueness on ip_address and mysr_id
  validates_uniqueness_of :user_id, :scope => [:model_year_service_id], if: "!user_id.blank?"
  validates_uniqueness_of :ip_address, :scope => [:model_year_service_id], if: "user_id.blank?"
  validates_uniqueness_of :session_id, :scope => [:model_year_service_id], if: "user_id.blank?"

  # Scopes
  scope :with_ip_address, ->(search) { where("ip_address = ?", "%#{search}%") }
  scope :with_session_id, ->(search) { where("session_id = ?", "%#{search}%") }
  scope :with_user_id,    ->(search) { where("user_id    = ?", "%#{search}%") }
end
