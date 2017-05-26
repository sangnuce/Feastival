class Profile < ApplicationRecord
  enum gender: [:male, :female, :other]

  mount_uploader :avatar, AvatarUploader

  belongs_to :user

  validates :name, presence: true, length: {maximum: 255}
  validates :birthday, presence: true
  validates :gender, presence: true
  validates :address, presence: true, length: {maximum: 300}
  validates :job, presence: true, length: {maximum: 200}
  validates :phonenumber, presence: true, numericality: true,
    length: {minimum: 10, maximum: 15}

  class << self
    def gender_attributes_for_select
      genders.map do |gender, _|
        [I18n.t("genders.#{gender}"), gender]
      end
    end
  end
end
