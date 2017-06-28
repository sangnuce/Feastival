require "rails_helper"

RSpec.feature "AuthenticateUsers", type: :feature do
  describe "authentication" do
    before do
      @user = FactoryGirl.create :user
      visit new_user_session_path
    end

    it "valid sign in" do
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Đăng nhập"
      expect(page).to have_content "Đăng nhập thành công."
    end

    it "invalid signin" do
      fill_in "Email", with: ""
      fill_in "Password", with: ""
      click_button "Đăng nhập"
      expect(page).to have_content "Mật khẩu hoặc Email không hợp lệ."
    end
  end

  describe "logout" do
    before do
      @user = FactoryGirl.create :user
      FactoryGirl.create :profile, user: @user
      login_as @user
      visit user_path @user
    end

    it "logout user" do
      click_link "logout"
      expect(page).to have_content "Đăng xuất thành công"
    end
  end
end
