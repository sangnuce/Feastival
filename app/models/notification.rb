class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true
  belongs_to :user
  after_create_commit :braodcast_notification

  validates :content, presence: true

  def broadcast_notification
    NotificationBroadcastJob.perform_later Notification.count, self
  end
end
