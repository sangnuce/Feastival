class Supports::User
  attr_reader :user

  def initialize args = {}
    @user = args[:user]
  end

  def groups args
    @groups =
      if args == "joined"
        @user.groups - @user.owned_groups
      elsif args == "created"
        @user.owned_groups
      else
        @user.groups
      end
  end

  def report
    @report = @user.reports.build
  end
end
