class Video < ActiveRecord::Base
  has_many :model_year_services, through: :model_year_service_videos
  has_many :votes
end
