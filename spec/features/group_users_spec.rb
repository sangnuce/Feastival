require "rails_helper"

RSpec.feature "users join or leave group", type: :feature do
  describe "Group from two users" do
    before :each do
      creator = FactoryGirl.create :user, email: "creator@gmail.com"
      FactoryGirl.create :profile, user: creator
      @group = FactoryGirl.create :group, creator: creator
      @user = FactoryGirl.create :user
      FactoryGirl.create :profile, user: @user
      login_as @user
    end

    it "user join a group" do
      visit group_path @group
      click_button "Tham gia"
      expect(page).to have_content "Bạn đã tham gia nhóm thành công"
    end

    it "visit a joined group" do
      FactoryGirl.create :group_user, group: @group, user: @user
      visit group_path @group
      expect(page).to have_content "Tin nhắn"
    end

    context "leave a group" do
      before do
        FactoryGirl.create :group_user, group: @group, user: @user
        visit group_path @group
      end

      it "doesnt let user rejoin" do
        click_link "Rời nhóm"
        visit group_path @group
        click_link "Tham gia"
        expect(page).to have_content "Bạn không thể tham gia nhóm này"
      end
    end
  end
end
