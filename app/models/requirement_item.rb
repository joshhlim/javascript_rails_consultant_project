class RequirementItem < ActiveRecord::Base
  # Callbacks
  before_save :process_detail, :unless => 'self.detail.blank?'
  
  # Associations
  belongs_to :requirement_category
  has_many   :model_year_service_requirements
  belongs_to :substitute_item, :class_name => 'RequirementItem'
  has_many   :substitution_slots, :class_name => 'RequirementItem', :foreign_key => 'substitute_requirement_item_id'
  has_many   :default_requirements
  has_many   :user_requirement_items
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
  
  # Validations
  validates_uniqueness_of :requirement_category_id, :scope => [:name, :detail]
  validates :name,  presence: true
  validates :requirement_category_id,  presence: true
  
  # Returns a full name, instead of just using year (e.g "2007 Ducati Monster" instead of "2007")
  def full_display
    return_string  = "#{name}" 
    return_string += " (#{detail})" unless detail.blank?
        
    return return_string
  end
  
  private
    def process_detail
      self.detail = self.detail.squish
      detail_numbers_str = self.detail.delete("^0-9")
      self.detail_numbers = detail_numbers_str.to_i unless detail_numbers_str.blank?
      self.detail_downcase_no_whitespace = self.detail.delete("\s+").downcase
      self.detail_characters = self.detail.delete("0-9").squish
    end
end
