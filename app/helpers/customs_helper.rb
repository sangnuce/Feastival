module CustomsHelper
  def get_avatar url_avatar
    if url_avatar.blank?
      "avatar.jpg"
    else
      url_avatar
    end
  end

  def check_join_group group_id
    return true unless current_user
    current_user.group_users.find_by(group_id: group_id).blank?
  end
end
