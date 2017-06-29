class Model < ActiveRecord::Base
  # Associations
  belongs_to :make
  has_many   :model_years, -> { order(year: :desc) }
  has_many   :specifications, through: :model_years
  
  # Validations
  validates_uniqueness_of :make_id, :scope => [:name]
  validates :name,  presence: true
  
  # Returns a full name, instead of just using year (e.g "Ducati Monster" instead of "Monster")
  def full_name
    return "#{make.name} #{name}"
  end
end
