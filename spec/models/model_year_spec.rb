require 'spec_helper'

describe ModelYear, type: :model do

  let(:make)  { FactoryGirl.create(:make) }
  let(:model) { make.models.build(make_id: make.id, name: 'Monster') }
  let(:model_year) { model.model_years.build(model_id: model.id, year: 2007)}


  subject { model_year }

  it { should be_valid }

  it { should respond_to(:year) }
  it { should respond_to(:model_id) }
  it { should respond_to(:model) }
  it { should respond_to(:make) }
  it { should have_one(:make)  }
  it { should belong_to(:model) }

  describe "when year is too early" do
    before { model_year.year = 1893 }
    it { should_not be_valid }
  end

  describe "when year is too late" do
    before { model_year.year = 3000 }
    it { should_not be_valid }
  end
end
