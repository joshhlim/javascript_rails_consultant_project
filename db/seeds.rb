require 'csv'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Load sample make, model, year data from CSV file Heroku limits hobby account to 10k rows,
# to stay below that threshold, data is very limited, can load full db when account is upgraded
puts "Creating Make, Model, and Model Year Data..."
CSV.foreach("#{Rails.root}/lib/data/MakeModelYearData-export.csv", :headers => true) do |row|
  print '.'
  #puts row
  make = Make.find_or_create_by(name: row['make'])
  #puts "Make: #{make.inspect}"
  model_name = row['model']
  if row['model'].blank?
    model_name = make.name
  end
  model = make.models.find_or_create_by(name: model_name)
  #puts "Model: #{model.inspect}"
  model_year = model.model_years.find_or_create_by(year: row['year'].to_i)
  #puts "Model Year: #{model_year.inspect}"
end


# This model_year_service is used as a sample, and only needs to be loaded once, outside the loop
sample_make = Make.find_by(name: "Ducati")
sample_model = sample_make.models.find_by(name: "Monster S2R 800")
sample_model_year = sample_model.model_years.find_by(year: 2007)

# Load sample services from CSV file, associate the services with the model_years
# TODO: May be smarter to only associate a core group of services to each model_year, rather than all of them
puts "Creating Service Data..."
CSV.foreach("#{Rails.root}/lib/data/VehicleServices-long.csv", :headers => true) do |row|
  print '.'
  service = Service.find_or_create_by(name: row['name'])
  service.description = row['description']
  service.popularity  = row['popularity_int'].to_i
  service.action      = row['action']
  service.item        = row['item']
  service.save!
  
  # Originally the seed file created a model_year_service link for all services and model years. This is unnecessary as
  # many of the links will never be needed (80/20 rule applies here), instead it will be created dynamically when
  # a user selects to view a certain service for a certain model year, we will load some samples though
  model_year_service = service.model_year_services.find_or_create_by(model_year_id: sample_model_year.id)

end

sample_model_year.model_year_services.load.each do |mys|
  if mys.interval.present?
    mys.interval.update(first_service_miles: 600, interval_miles: 7500, interval_months: 12)
  else
    mys.create_interval(first_service_miles: 600, interval_miles: 7500, interval_months: 12)
    mys.save!
  end
  
end
sample_service = Service.find_by(name: "Oil & Filter Change")
# This is to handle a change in the name of this service - difference between different environments
sample_service ||= Service.find_by(name: "Change Engine Oil & Filter")

sample_model_year_service = ModelYearService.find_or_create_by(service_id: sample_service.id, model_year_id: sample_model_year.id)

puts "Creating Tool and Supply Data..."
CSV.foreach("#{Rails.root}/lib/data/ToolSupplyData.csv", :headers => true) do |row|
  print '.'
  category = RequirementCategory.find_or_create_by(name: row['category'])
  requirement_item = category.requirement_items.find_or_create_by(name: row['name'], detail: row['detail'])
  requirement_item.needs_detail = row['needs_detail']
  requirement_item.needs_quantity = row['needs_quantity']
  requirement_item.detail = row['detail']
  requirement_item.link_for_sale = row['link_for_sale']
  
  # If anything exists in the listed column index, there is a substitute item
  substitute_requirement_item = nil
  if !row['sub_name'].blank?
    substitute_category = RequirementCategory.find_or_create_by(name: row['sub_category'])
    substitute_requirement_item = category.requirement_items.find_or_create_by(name: row['sub_name'])
    substitute_requirement_item.detail = row['sub_detail']
    substitute_requirement_item.link_for_sale = row['sub_link_for_sale']
    substitute_requirement_item.save!
    requirement_item.substitute_requirement_item_id = substitute_requirement_item.id
  end
  
  requirement_item.save!

# Code block below loads tools/supplies w/ detail and quantity for a specific bike.
  if row['use_sample']  
    model_year_service_requirement = 
      sample_model_year_service.model_year_service_requirements.find_or_create_by(model_year_service_id: sample_model_year_service.id,
                                                                           requirement_category_id: category.id,
                                                                           requirement_item_id: requirement_item.id)
    if substitute_requirement_item.present?
      model_year_service_requirement.substitute_requirement_item_id = substitute_requirement_item.id
    end
                                                            
    model_year_service_requirement.quantity = row['quantity'].to_i
    model_year_service_requirement.quantity_unit = row['quantity_unit']
    model_year_service_requirement.save!
  end
  
end

# Load the votes types available
vote_type = VoteType.find_or_create_by(name: "Confirm")
vote_type.description = "Confirm entry"
vote_type.save!
vote_type = VoteType.find_or_create_by(name: "Reject")
vote_type.description = "Reject entry"
vote_type.save!
vote_type = VoteType.find_or_create_by(name: "Up")
vote_type.description = "Up-vote the entry"
vote_type.save!
vote_type = VoteType.find_or_create_by(name: "Down")
vote_type.description = "Down-vote the entry"
vote_type.save!
vote_type = VoteType.find_or_create_by(name: "Spam")
vote_type.description = "Mark the entry as Spam"
vote_type.save!
vote_type = VoteType.find_or_create_by(name: "Flag")
vote_type.description = "Flag as inappropriate"
vote_type.save!
vote_type = VoteType.find_or_create_by(name: "Optional")
vote_type.description = "Mark the entry as Optional"
vote_type.save!
vote_type = VoteType.find_or_create_by(name: "Best")
vote_type.description = "Best entry in the list"
vote_type.save!
vote_type = VoteType.find_or_create_by(name: "Worst")
vote_type.description = "Worst entry in the list"
vote_type.save!

# Seed features to be requested
feature = Feature.find_or_create_by(name: "Maintenance Log")
feature.description = "Allow users to save a record of each maintenance activity in a log."
feature.save!

# Load some sample specs
puts "Creating Sample Spec Data..."
CSV.foreach("#{Rails.root}/lib/data/specs.csv", :headers => true) do |row|
  print '.'
  make = Make.find_or_create_by(name: row['Make'])
  model = make.models.find_or_create_by(name: row['Model'])
  model_year = model.model_years.find_or_create_by(year: row['Year'].to_i)
  specification_category = SpecificationCategory.find_or_create_by(name: row['name'])
  specification = specification_category.specifications.find_or_create_by(model_year_id: model_year.id)
  specification.single_value_str = row['single_value_str']
  specification.range_start_str = row['range_start_str']
  specification.range_end_str = row['range_end_str']
  specification.is_quick_spec = row['is_quick_spec']
  specification.save!
  
  service = Service.find_by(name: row['Service'])
  if service.present?
    model_year_service = ModelYearService.find_or_create_by(service_id: service.id, model_year_id: model_year.id)
    ModelYearServiceSpecification.find_or_create_by(specification_id: specification.id, model_year_service_id: model_year_service.id)
  end

end

puts "Creating Service Default Requirement Data..."
CSV.foreach("#{Rails.root}/lib/data/ServiceDefaultRequirements.csv", :headers => true) do |row| 
  print '.'
  service = Service.find_or_create_by(name: row['Service'])
  requirement_category = RequirementCategory.find_by(name: row['Category'])
  requirement_item = requirement_category.
                        requirement_items.
                        find_by(name: row['Item'], detail: nil)
  default_requirement = DefaultRequirement.find_or_create_by(service_id: service.id, 
                                                             requirement_item_id: requirement_item.id)
end

puts "Creating Video Data..."
CSV.foreach("#{Rails.root}/lib/data/Videos.csv", :headers => true) do |row|
  print '.'
  make = Make.find_by(name: row['make'])
  model = make.models.find_by(name: row['model']) 
  model_year = model.model_years.find_by(year: row['year'])
  service = Service.find_by(name: row['service'])
  model_year_service = model_year.model_year_services.find_or_create_by(service_id: service.id, model_year_id: model_year.id)
  
  video = Video.find_or_create_by(url: row['url'])
  video.title = row['title']
  video.description = row['description']
  video.thumbnail_default_url = row['thumbnail_default_url']
  video.notes = row['notes']
  video.external_source = row['external_source']
  video.external_id = row['external_id']
  video.save!
  
  ModelYearServiceVideo.find_or_create_by(model_year_service_id: model_year_service.id, video_id: video.id)

end
