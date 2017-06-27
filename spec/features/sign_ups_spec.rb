require "rails_helper"

RSpec.feature "user signing up" do
  before do
    visit signup_path
  end

  scenario "invalid signup" do
    fill_in "user_email", with: ""
    fill_in "user_password", with: "a"
    fill_in "user_password_confirmation", with: "b"
    fill_in "user_profile_attributes_name", with: ""
    fill_in "user_profile_attributes_birthday", with: ""
    fill_in "user_profile_attributes_address", with: ""
    fill_in "user_profile_attributes_job", with: ""
    fill_in "user_profile_attributes_phonenumber", with: ""
    click_button "Tạo tài khoản"
    expect(page).to have_content "Biễu mẫu có 8 Lỗi."
  end

  scenario "valid signup" do
    fill_in "user_email", with: "a@example.com"
    fill_in "user_password", with: "123456"
    fill_in "user_password_confirmation", with: "123456"
    fill_in "user_profile_attributes_name", with: "Vinh"
    fill_in "user_profile_attributes_birthday", with: "1995-02-01"
    fill_in "user_profile_attributes_address", with: "434 Tran Khat Chan"
    fill_in "user_profile_attributes_job", with: "Programmer"
    fill_in "user_profile_attributes_phonenumber", with: "+84943979669"
    click_button "Tạo tài khoản"
    expect(page).to have_content "Chào mừng! Bạn đã đăng ký thành công!"
  end
end
