require "rails_helper"

RSpec.describe GroupsController, type: :controller do
  describe " GET #index" do
    it "response with success" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it "render index template" do
      get :index
      expect(response).to render_template "index"
    end

    it "loads all groups" do
      user2 = FactoryGirl.create :user, email: "b@example.com"
      group1 = FactoryGirl.create :group
      group2 = FactoryGirl.create :group, creator: user2
      get :index
      expect(assigns(:groups)).to match_array [group1, group2]
    end
  end

  describe "GET #show" do
    before do
      @group = FactoryGirl.create :group
    end

    it "response with succes" do
      get :show, params: {id: 1}
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it "render show template" do
      get :show, params: {id: 1}
      expect(response).to render_template "show"
    end

    it "load the correct group" do
      get :show, params: {id: 1}
      expect(assigns(:group)).to eq @group
    end
  end
end
