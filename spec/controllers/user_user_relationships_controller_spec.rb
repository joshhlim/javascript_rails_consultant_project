require 'spec_helper'

describe UserUserRelationshipsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  before { sign_in user, no_capybara: true }

  describe "creating a relationship with Ajax" do

    it "should increment the Relationship count" do
      expect do
        params = { user_user_relationship: { followed_id: other_user.id } }
        post :create, params: params, xhr: true
      end.to change(UserUserRelationship, :count).by(1)
    end

    it "should respond with success" do
      params = { user_user_relationship: { followed_id: other_user.id } }
      post :create, params: params, xhr: true
      expect(response).to be_success
    end
  end

  describe "destroying a relationship with Ajax" do

    before { user.follow!(other_user) }
    let(:relationship) do
      user.user_user_relationships.find_by(followed_id: other_user.id)
    end

    it "should decrement the Relationship count" do
      expect do
        delete :destroy, params: { id: relationship.id }, xhr: true
      end.to change(UserUserRelationship, :count).by(-1)
    end

    it "should respond with success" do
      delete :destroy, params: { id: relationship.id }, xhr: true
      expect(response).to be_success
    end
  end
end
