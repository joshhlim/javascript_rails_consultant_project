class ModelYearServiceVideo < ActiveRecord::Base
  belongs_to :model_year_service
  belongs_to :video
  
  validates_presence_of :model_year_service_id
  validates_presence_of :video_id
end
