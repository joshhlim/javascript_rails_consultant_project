class Vote < ActiveRecord::Base
  #Associations
  belongs_to :user
  belongs_to :vote_type

  belongs_to :specification
  belongs_to :model_year_service_specification
  belongs_to :video
  belongs_to :interval

  # Validations
  # TODO: As more categories become "votable" this style of validation becomes ugly, need to refactor when possible
  # For a user, validate that record is unique by user_id and what they are voting on, for guest, validate
  # uniqueness on ip_address/session and what they are voting on
  validate :only_one_present?

  validates_uniqueness_of :user_id, :scope => [:specification_id], if: :is_user_specification_vote?
  validates_uniqueness_of :ip_address, :scope => [:specification_id], if: :is_visitor_specification_vote?
  validates_uniqueness_of :session_id, :scope => [:specification_id], if: :is_visitor_specification_vote?

  validates_uniqueness_of :user_id, :scope => [:model_year_service_specification_id], if: :is_user_model_year_service_specification_vote?
  validates_uniqueness_of :ip_address, :scope => [:model_year_service_specification_id], if: :is_visitor_model_year_service_specification_vote?
  validates_uniqueness_of :session_id, :scope => [:model_year_service_specification_id], if: :is_visitor_model_year_service_specification_vote?

  validates_uniqueness_of :user_id, :scope => [:video_id], if: :is_user_video_vote?
  validates_uniqueness_of :ip_address, :scope => [:video_id], if: :is_visitor_video_vote?
  validates_uniqueness_of :session_id, :scope => [:video_id], if: :is_visitor_video_vote?

  validates_uniqueness_of :user_id,    :scope => [:interval_id], if: :is_user_interval_vote?
  validates_uniqueness_of :ip_address, :scope => [:interval_id], if: :is_visitor_interval_vote?
  validates_uniqueness_of :session_id, :scope => [:interval_id], if: :is_visitor_interval_vote?

  # Scopes
  scope :with_ip_address, ->(search) { where("ip_address = ?", "%#{search}%") }
  scope :with_session_id, ->(search) { where("session_id = ?", "%#{search}%") }
  scope :with_user_id,    ->(search) { where("user_id    = ?", "%#{search}%") }

  def only_one_present?
    [self.specification_id,
     self.model_year_service_specification_id,
     self.video_id,
     self.interval_id].reject(&:blank?).size == 1
  end

  def is_visitor_specification_vote?
    user_id.blank? && specification_id.present?
  end

  def is_user_specification_vote?
    !user_id.blank? && specification_id.present?
  end

  def is_visitor_model_year_service_specification_vote?
    user_id.blank? && model_year_service_specification_id.present?
  end

  def is_user_model_year_service_specification_vote?
    !user_id.blank? && model_year_service_specification_id.present?
  end

  def is_visitor_video_vote?
    user_id.blank? && video_id.present?
  end

  def is_user_video_vote?
    !user_id.blank? && video_id.present?
  end

  def is_visitor_interval_vote?
    user_id.blank? && interval_id.present?
  end

  def is_user_interval_vote?
    user_id.present? && interval_id.present?
  end
end
