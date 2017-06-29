class ModelYearService < ActiveRecord::Base
  # Associations
  belongs_to :model_year
  belongs_to :service
  belongs_to :interval
  has_many   :model_year_service_requirements
  has_many   :requirement_items, through: :model_year_service_requirements
  has_many   :requirement_categories, through: :model_year_service_requirements
  has_many   :model_year_service_update_requests
  has_many   :model_year_service_interval_votes
  has_many   :model_year_service_specifications
  has_many   :specifications, through: :model_year_service_specifications
  has_many   :model_year_service_videos
  has_many   :videos, through: :model_year_service_videos

  #Scopes
  scope :request_count, -> { order_by(:model_year_service_update_requests_count => :desc) }
  scope :main_services, -> { where(service_id: [1, 4, 5, 20, 23])}

  # Validations
  validates_uniqueness_of :model_year_id, :scope => [:service_id]
  validates :model_year_id,  presence: true
  validates :service_id,  presence: true

  # Public methods

  # The interval fields were moved to another model, these are for backwards compatibility
  def first_service_miles
    self.interval.first_service_miles unless self.interval.blank?
  end

  def interval_miles
    self.interval.interval_miles unless self.interval.blank?
  end

  def interval_months
    self.interval.interval_months unless self.interval.blank?
  end

  def need_service?(mileage)
    if mileage == nil
      mileage = 0
    end
    mileage_intervals = mileage % self.interval_miles
    if mileage >= (first_service_miles - 100) && mileage <= first_service_miles
      return true
    elsif
      mileage_intervals >= (interval_miles - 100)
      return true
    else
      false
    end
  end

end
