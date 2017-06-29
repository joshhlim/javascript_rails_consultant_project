require 'spec_helper'

describe Model do

  let(:make)  { FactoryGirl.create(:make) }
  let(:model) { make.models.build(make_id: make.id, name: 'Monster') }

  subject { model }

  it { should be_valid }

  it { should respond_to(:name) }
  it { should respond_to(:make_id) }
  it { expect(make).to eq make }

  describe "when name is not present" do
    before { model.name = " " }
    it { should_not be_valid }
  end

  describe "when model name is taken for make" do
    before do
      model_duplicate = model.dup
      model_duplicate.save
    end

    it { should_not be_valid }
  end

  describe "when same model name, different make" do
    let(:new_make) { FactoryGirl.create(:new_make) }
    let(:new_model_same_name) { make.models.build(make_id: make.id, name: 'Monster') }

    it { should be_valid }
  end
end
