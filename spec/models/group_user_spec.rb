require "rails_helper"

RSpec.describe GroupUser, type: :model do
  describe "database column" do
    it {should have_db_column(:user_id).of_type(:integer)}
    it {should have_db_column(:group_id).of_type(:integer)}
  end

  describe "associations" do
    it {should belong_to :user}
    it {should belong_to :group}
  end

  describe "validation" do
    it "validate group_user" do
      creator = FactoryGirl.create :user, email: "creator@gmail.com"
      group = FactoryGirl.create :group, creator: creator
      user = FactoryGirl.create :user
      relationship1 = FactoryGirl.create :group_user, group: group, user: user
      relationship2 = FactoryGirl.build :group_user, group: group, user: user
      expect(relationship2).not_to be_valid
    end
  end
end
