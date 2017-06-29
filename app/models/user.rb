class User < ActiveRecord::Base
  # Associations
  has_many :microposts, dependent: :destroy
  has_many :user_user_relationships, 
           foreign_key: "follower_id", 
           dependent: :destroy
  has_many :followed_users, through: :user_user_relationships, source: :followed
  has_many :reverse_user_user_relationships, foreign_key: "followed_id",
                                             class_name:  "UserUserRelationship",
                                             dependent:   :destroy
  has_many :followers, through: :reverse_user_user_relationships, source: :follower
  has_many :user_vehicles
  has_many :model_year_service_update_requests
  has_many :user_requirement_items
  
  # Before filters
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  
  # Validations
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  # Tokens for user sessions
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def User.digest(token)
    Digest::SHA2.hexdigest(token.to_s)
  end
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    # Validations are skipped for updating "password_reset_token"
    # and "password_reset_sent_at" - otherwise save will fail as
    # password attribute is nil
    save!(validate: false)
    UserMailer.password_reset(self).deliver
  end
  
  # Generate feed for user
  def feed
    Micropost.from_users_followed_by(self)
  end
  
  def following?(other_user)
    user_user_relationships.find_by(followed_id: other_user.id)
  end
  
  def follow!(other_user)
    user_user_relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    user_user_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  private
    
    # For Session tokens
    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
    
    # For Password reset tokens
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end
end
