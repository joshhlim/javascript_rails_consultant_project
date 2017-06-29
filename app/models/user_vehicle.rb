class UserVehicle < ActiveRecord::Base
  belongs_to :model_year
  belongs_to :user
  has_many   :model_year_services, through: :model_year

  validates :model_year_id,  presence: true
  validates :user_id,  presence: true

  def full_display
    text  = "#{model_year.name}"
    text += " (#{name})" unless name.blank?
    return text
  end
end
