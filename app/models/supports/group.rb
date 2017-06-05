class Supports::Group
  attr_reader :group

  def initialize args = {}
    @group = args[:group]
  end

  def all
    Group.all
  end

  def message
    Message.new
  end

  def group_user
    @group.group_users.build
  end

  def leave user
    GroupUser.find_by user_id: user.id, group_id: @group.id
  end

  def report
    @group.reports.build
  end

  def users
    @group.users
  end
end
