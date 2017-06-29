class Group < ApplicationRecord
  enum status: [:fail, :success]

  belongs_to :category
  belongs_to :creator, class_name: User.name
  belongs_to :place

  has_many :group_users, dependent: :destroy
  has_many :leave_groups, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_many :reports, as: :reported, dependent: :destroy
  has_many :users, through: :group_users

  validates :address, :category, :size, :time, :title, presence: true

  def owned_by? user
    return false unless user
    self.creator_id == user.id
  end

  class << self
    def status_attributes_for_select
      statuses.map do |status, _|
        [I18n.t("statuses.#{status}"), status]
      end
    end
  end

  def check_leave user
    return false unless user
    self.leave_groups.pluck(:user_id).include? user.id
  end

  scope :odered_by_time, ->{order time: :desc}
  scope :created_in_time, ->start_time, end_time do
    where created_at: start_time..end_time
  end
end
