class ModelYear < ActiveRecord::Base
  # Associations
  belongs_to :model
  has_one    :make, through: :model
  has_many   :model_year_services
  has_many   :model_year_update_requests
  has_many   :specifications
  has_many   :specification_categories, through: :specifications
  
  # Validations
  EARLIEST_YEAR_ALLOWED = 1894
  validates :year, :inclusion => {:in => EARLIEST_YEAR_ALLOWED..Time.now.year+2}
  
  # Returns a full name, instead of just using year (e.g "2007 Ducati Monster" instead of "2007")
  def name
    return "#{year.to_s} #{make.name} #{model.name}"
  end
end
