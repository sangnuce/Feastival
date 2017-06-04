class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.new_record?
      can :read, [Group, User]
    elsif user.is_admin?
      can :manage, :all
    else
      can :read, [Group, User]
      can [:create, :new], Group
      can [:edit, :update], User, id: user.id
      can [:edit, :update], Group, creator_id: user.id
      can :destroy, GroupUser do |group_user|
        user == group_user.group.creator
      end
    end
  end
end
