require "rails_helper"

RSpec.describe Place, type: :model do
  describe "database colum" do
    it {is_expected.to have_db_column(:title).of_type(:string)}
    it {is_expected.to have_db_column(:address).of_type(:text)}
    it {is_expected.to have_db_column(:longitude).of_type(:float)}
    it {is_expected.to have_db_column(:latitude).of_type(:float)}
    it {is_expected.to have_db_column(:website).of_type(:string)}
    it {is_expected.to have_db_column(:description).of_type(:text)}
    it {is_expected.to have_db_column(:phonenumber).of_type(:string)}
    it {is_expected.to have_db_column(:category_id).of_type(:integer)}
    it {is_expected.to have_db_column(:manager_id).of_type(:integer)}
  end

  describe "association" do
    it {is_expected.to belong_to :manager}
    it {is_expected.to belong_to :category}

    it {is_expected.to have_many :groups}
    it {is_expected.to have_many :menus}
  end

  describe "#title" do
    subject {FactoryGirl.create :place}
    before {subject.title = ""}
    it {is_expected.to have(1).error_on(:title)}
  end

  describe "#address" do
    subject {FactoryGirl.create :place}
    before {subject.address = ""}
    it {is_expected.to have(1).error_on(:address)}
  end
end
