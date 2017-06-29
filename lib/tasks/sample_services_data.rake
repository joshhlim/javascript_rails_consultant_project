require 'csv'

namespace :db do
  desc "Fill database with sample data"
  task populate_services: :environment do
    make_services
  end
end

def make_services
  
  CSV.foreach("#{Rails.root}/lib/data/VehicleServices.csv") do |row|
    service = Service.find_or_create_by(name:        row[0],
                                        description: row[1],
                                        popularity:  row[2].to_i)
  end

end