require "rails_helper"

RSpec.describe Group, type: :model do
  describe "database structure" do
    context "column" do
      it {should have_db_column(:title).of_type(:string)}
      it {should have_db_column(:address).of_type(:text)}
      it {should have_db_column(:time).of_type(:datetime)}
      it {should have_db_column(:creator_id).of_type(:integer)}
      it {should have_db_column(:category_id).of_type(:integer)}
      it {should have_db_column(:size).of_type(:integer)}
      it {should have_db_column(:longitude).of_type(:float)}
      it {should have_db_column(:latitude).of_type(:float)}
      it {should have_db_column(:status).of_type(:integer)}
      it {should have_db_column(:completed).of_type(:boolean)}
    end
  end

  describe "validations" do
    before do
      @group = FactoryGirl.build :group
    end

    it "validate group" do
      expect(@group).to be_valid
    end

    it "invalidate blank address" do
      @group.address = ""
      expect(@group).not_to be_valid
    end

    it "invalidate blank time" do
      @group.time = ""
      expect(@group).not_to be_valid
    end

    it "invalidate blank size" do
      @group.size = ""
      expect(@group).not_to be_valid
    end

    it "invalidate blank title" do
      @group.title = ""
      expect(@group).not_to be_valid
    end
  end

  describe "associations" do
    it {should have_many :users}
    it {should have_many :group_users}
    it {should have_many :leave_groups}
    it {should have_many :messages}

    it {should belong_to :creator}
    it {should belong_to :category}
  end

end
