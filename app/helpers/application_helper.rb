module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "zaftool"
    if page_title.empty?
    base_title
    else
      "#{base_title} | #{page_title}".html_safe
    end
  end

  def image_tag_thumbnail_from_make_model_year(make, model, year)
    # Try to find the specific make/model/year first
    filename = Dir["#{Rails.root}/app/assets/images/#{make.downcase}*#{model.downcase}*#{year}*thumbnail*"].first
    # Then try just make/model
    filename ||= Dir["#{Rails.root}/app/assets/images/#{make.downcase}*#{model.downcase}*thumbnail*"].first

    if filename.present?
      image_tag(File.basename(filename), alt: "#{make} #{model}", class: "vehicle-image")
    else
      image_tag("default-motorcycle.jpg", alt: "Default Motorcycle", class: "vehicle-image")
    end
  end

  def image_tag_thumbnail_from_model_full_name(model_full_name)
    filename = Dir["#{Rails.root}/app/assets/images/#{model_full_name}*thumbnail*"].first
    if filename.present?
      image_tag(File.basename(filename), alt: model_full_name, class: "vehicle-image")
    else
      image_tag("default-motorcycle.jpg", alt: "Default Motorcycle", class: "vehicle-image")
    end
  end

  def image_tag_thumbnail_from_make_name(make_name)
    filename = Dir["#{Rails.root}/app/assets/images/#{make_name.downcase}*logo*thumbnail*"].first

    if filename.present?
      image_tag(File.basename(filename), alt: make_name, class: "vehicle-image")
    else
      image_tag("default-motorcycle.jpg", alt: "Default Motorcycle", class: "vehicle-image")
    end
  end

  def flash_display
    response = ""
    flash.each do |name, msg|
      response = response + content_tag(:div, msg, :id => "flash_#{name}", :class => bootstrap_class_for(name) )
    end
    flash.discard
    response
  end

  def bootstrap_class_for(flash_type)
    case flash_type
    when 'success'
      return "alert-success"
    when 'error'
      return "alert-danger"
    when 'alert'
      return "alert-warning"
    when 'notice'
      return "alert-info"
    else
      return flash_type.to_s
    end
  end

  def amazon_associate_id
    "zaftool-20"
  end

  def confirm_class_list
    @confirm_class_list = 'zf-confirm'
  end

  def reject_class_list
    'zf-reject'
  end

  def add_class_list
    'zf-add'
  end

  def add_tooltip_text
    'Add to your toolbox'
  end

  def edit_class_list
    'zf-edit'
  end

  def minus_class_list
    'zf-minus'
  end

  def text_class_list
    'text'
  end
end
