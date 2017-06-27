require "rails_helper"

RSpec.describe GroupUsersController, type: :controller do
  before :all do
    FactoryGirl.create :group_user
  end
  describe "POST #create" do
    it "redirect to login" do
      post :create
      expect(response).to redirect_to new_user_session_path
    end
  end
end
