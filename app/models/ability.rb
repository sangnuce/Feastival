class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.new_record?
      can :read, [Group, User, Place]
    elsif user.is_admin?
      can :manage, :all
    elsif user.is_manager?
      can [:manage], [Place, Menu, MenuItem]
      can [:edit, :update], User, id: user.id
    else
      can :read, [Group, User, Place]
      can [:create, :new], Group
      can [:edit, :update], User, id: user.id
      can [:edit, :update], Group, creator_id: user.id
      can :destroy, GroupUser do |group_user|
        user == group_user.group.creator
      end
      can :create, Report
    end
  end
end
