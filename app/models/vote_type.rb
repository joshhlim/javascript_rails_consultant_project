class VoteType < ActiveRecord::Base
  has_many :model_year_service_requirement_votes
end
