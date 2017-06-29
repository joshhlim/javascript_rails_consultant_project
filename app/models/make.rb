class Make < ActiveRecord::Base
  # Associations
  has_many :models, -> { order(name: :asc) }
  has_many :model_years, -> { order(year: :desc) }, through: :models
  
  # Validations
  validates_uniqueness_of :name
  validates :name,  presence: true
end
