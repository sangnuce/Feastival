class Place < ApplicationRecord
  belongs_to :category
  belongs_to :manager, class_name: User.name

  has_many :groups, dependent: :destroy
  has_many :menus, dependent: :destroy

  validates :address, :title, presence: true
end
