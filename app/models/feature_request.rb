class FeatureRequest < ActiveRecord::Base
  # Callbacks
  before_save :record_is_guest
  
  # Associations
  belongs_to :feature
  belongs_to :user
  
  validates_uniqueness_of :user_id, :scope => [:feature_id], if: :is_user_request?
  validates_uniqueness_of :ip_address, :scope => [:feature_id], if: :is_visitor_request? 
  validates_uniqueness_of :session_id, :scope => [:feature_id], if: :is_visitor_request?
  
  def is_visitor_request?
    user_id.blank?
  end
  
  def is_user_request?
    !user_id.blank?
  end
  
  private
    def record_is_guest
      if user_id.blank?
        self.is_guest = true
      else
        self.is_guest = false
      end
      return true # If false is the last thing returned, rails will rollback the transaction as if the record exists
    end
end
