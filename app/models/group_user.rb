class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :group_id, uniqueness: {scope: :user_id}

  def left_group
    self.destroy
    self.group.leave_groups.create user: self.user
  end
end
