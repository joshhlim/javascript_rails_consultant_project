module SpecificationsHelper
  
  def print_spec(spec)
    if spec.single_value_str.present?
      if spec.range_start_str.present? && spec.range_end_str.present?
        "#{print_spec_single_value(spec)}: #{print_spec_range(spec)}"
      else 
        spec.single_value_str
      end
    elsif spec.range_start_str.present? || spec.range_end_str.present?
      print_spec_range(spec)
    else
      "Missing Spec"
    end
  end
  
  def print_spec_single_value(spec)
    spec.single_value_str
  end
  
  def print_spec_range(spec)
    "#{spec.range_start_str}-#{spec.range_end_str}" unless spec.range_start_str.blank? && spec.range_end_str.blank?
  end
  
  def reject_popover_html(spec)
    # TODO: Would be good to move the generation of popover_html string into a helper
  end
  
end