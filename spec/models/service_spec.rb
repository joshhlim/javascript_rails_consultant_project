require 'spec_helper'

describe Service do
  
  before { @service = Service.new(name: "Oil Change") }

  subject { @service }
  
  it { should respond_to(:name) }
  
  describe "when name is not present" do
    before { @service.name = " " }
    it { should_not be_valid }
  end
  
  describe "when service name is taken" do
    before do
      service_duplicate = @service.dup
      service_duplicate.save
    end
  
    it { should_not be_valid }
  end
end
