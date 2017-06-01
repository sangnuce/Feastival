class Group < ApplicationRecord
  belongs_to :creator, class_name: User.name
  belongs_to :category

  has_many :group_users, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :notifications, as: :source, dependent: :destroy
  has_many :reports, as: :reported, dependent: :destroy
  has_many :users, through: :group_users

  validates :address, :time, :size, :title, :category, presence: true

  geocoded_by :address
  after_validation :geocode
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
end
