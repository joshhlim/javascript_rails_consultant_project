require 'spec_helper'

describe Make do
  
  before { @make = Make.new(name: "Ducati") }

  subject { @make }
  
  it { should respond_to(:name) }
  
  describe "when name is not present" do
    before { @make.name = " " }
    it { should_not be_valid }
  end
  
  describe "when make name is taken" do
    before do
      make_duplicate = @make.dup
      make_duplicate.save
    end
  
    it { should_not be_valid }
  end
end
