require "rails_helper"

RSpec.describe Profile, type: :model do
  describe "database structure" do
    context "column" do
      it {should have_db_column(:user_id).of_type(:integer)}
      it {should have_db_column(:name).of_type(:string)}
      it {should have_db_column(:birthday).of_type(:date)}
      it {should have_db_column(:gender).of_type(:integer)}
      it {should have_db_column(:address).of_type(:text)}
      it {should have_db_column(:phonenumber).of_type(:string)}
      it {should have_db_column(:description).of_type(:text)}
      it {should have_db_column(:job).of_type(:string)}
    end
  end

  describe "validations" do
    before do
      @profile = FactoryGirl.create(:profile)
    end

    it {should validate_presence_of :name}
    it {should validate_presence_of :birthday}
    it {should validate_length_of :address}
    it {should validate_presence_of :gender}
    it {should validate_presence_of :phonenumber}

    it "invalidate blank name" do
      @profile.name = ""
      expect(@profile).not_to be_valid
    end

    it "invalidate blank birthday" do
      @profile.birthday = ""
      expect(@profile).not_to be_valid
    end

    it "invalidate blank address" do
      @profile.address = ""
      expect(@profile).not_to be_valid
    end

    it "invalidate long address" do
      @profile.address = "a"*301
      expect(@profile).not_to be_valid
    end

    it "invalidate blank phonenumber" do
      @profile.phonenumber = ""
      expect(@profile).not_to be_valid
    end
  end

  describe "associations" do
    it {should belong_to :user}
  end
end
