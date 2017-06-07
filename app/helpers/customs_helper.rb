module CustomsHelper
  def user_avatar url_avatar
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

  def count_user_create_group
    if user_signed_in?
      start_date = Time.zone.now.to_date.beginning_of_day
      end_date = Time.zone.now.to_date.end_of_day
      count = Group.where(creator: current_user,
        created_at: start_date..end_date).count
    end

    count
  end
end
