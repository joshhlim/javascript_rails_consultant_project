class Service < ActiveRecord::Base
  # Callbacks
  before_save :generate_item_action_display

  # Associations
  has_many :model_year_services
  has_many :model_years, -> { order(year: :desc) }, through: :model_year_services
  has_many :default_requirements

  # Validations
  validates_uniqueness_of :name
  validates :name,  presence: true

  private
    def generate_item_action_display
      self.item_action_display = "#{self.item}"
      self.item_action_display += " (#{self.action})"
    end
end
