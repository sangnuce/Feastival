require "rails_helper"

RSpec.describe User, type: :model do
  describe "database structure" do
    context "column" do
      it {should have_db_column(:id).of_type(:integer)}
      it {should have_db_column(:email).of_type(:string)}
      it {should have_db_column(:is_admin).of_type(:boolean)}
      it {should have_db_column(:encrypted_password).of_type(:string)}
    end
  end


  describe "validations" do
    before :each do
      @user = FactoryGirl.build :user
    end

    it "validate valid users" do
      expect(@user).to be_valid
    end

    it "invalidate blank email" do
      @user.email = ""
      expect(@user).not_to be_valid
    end

    it "invalidate blank password" do
      @user.password = ""
      expect(@user).not_to be_valid
    end

    it "invalidtae short password" do
      @user.password = "a"*5
      expect(@user).not_to be_valid
    end


    it "invalidate different password confirmation" do
      @user.password = "123456"
      @user.password_confirmation = "654312"
      expect(@user).not_to be_valid
    end

    it "validate uniqueness of email" do
      @user.save
      @user2 = FactoryGirl.build(:user)
      @user2.save
      expect(@user2).not_to be_valid
    end
  end

  describe "association" do
    it {should have_one :profile}
    it {should have_many :groups}
    it {should have_many :group_users}
    it {should have_many :created_groups}
    it {should have_many :leave_groups}
    it {should have_many :messages}
    it {should have_many :owned_reports}
    it {should have_many :reports}
  end
end
