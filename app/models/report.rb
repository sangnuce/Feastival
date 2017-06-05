class Report < ApplicationRecord
  belongs_to :reporter, class_name: User.name
  belongs_to :reported, polymorphic: true

  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :content, presence: true

  scope :not_resolved, ->{where resolved: false}
end
