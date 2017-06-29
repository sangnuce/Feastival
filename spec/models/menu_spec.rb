require "rails_helper"

RSpec.describe Menu, type: :model do
  describe "database column" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:place_id).of_type(:integer)}
    it {is_expected.to have_db_column(:description).of_type(:text)}
  end

  describe "associations" do
    it {is_expected.to have_one :picture}
  end
end
