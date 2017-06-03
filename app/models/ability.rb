class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.new_record?
      can :read, [Group, User]
    elsif user.is_admin?
      can :manage, :all
    else
      can [:create, :new], Group
      can [:edit, :update], User, id: user.id
    end
  end
end
