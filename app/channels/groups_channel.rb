class GroupsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "groups_#{params['group_id']}_channel"
  end

  def unsubscribed
  end

  def send_message data
    current_user.messages.create! content: data["message"],
      group_id: data["group_id"]
  end
end
