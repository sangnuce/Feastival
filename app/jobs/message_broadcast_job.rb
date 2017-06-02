class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform message
    ActionCable.server.broadcast "groups_#{message.group.id}_channel",
      message: message.attributes.merge(user_avatar: message.user
        .profile.avatar.url)
  end
end
