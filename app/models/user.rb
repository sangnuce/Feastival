class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable,
    :validatable

  has_one :profile, dependent: :destroy

  has_many :owned_groups, foreign_key: :creator_id,
    class_name: Group.name, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :group_users, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :reports, dependent: :destroy, foreign_key: :reporter_id

  accepts_nested_attributes_for :profile, update_only: true

  def current_user? user
    user == self
  end
end
