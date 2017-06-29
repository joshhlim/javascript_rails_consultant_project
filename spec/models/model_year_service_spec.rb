require 'spec_helper'

describe ModelYearService, type: :model do
  let!(:make)  { FactoryGirl.create(:make) }
  let!(:model) { make.models.create(make_id: make.id, name: 'Monster') }
  let!(:model_year) { model.model_years.create(model_id: model.id, year: 2007)}
  let!(:service) { Service.create(name: "Oil Change") }
  let!(:model_year_service) { service.model_year_services.build(model_year_id: model_year.id) }

  subject { model_year_service }

  it { should be_valid }

  it { should respond_to(:model_year_id) }
  it { should respond_to(:service_id) }
  it { should respond_to(:touch_count) }
  it { should respond_to(:model_year_service_update_requests_count) }
  it { should respond_to(:view_count) }
  it { should respond_to(:video_url) }
  it { should respond_to(:mechanic_search_string) }
  it { should respond_to(:notes) }
  it { should respond_to(:interval_miles) }
  it { should respond_to(:interval_months) }
  it { should belong_to(:model_year)  }
  it { should belong_to(:service) }
end
