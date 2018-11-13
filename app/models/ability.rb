class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can :manage, UserFavorite

    if user.admin?
      can :manage, Country
      can :manage, Language
      can :manage, Jurisdiction
      can :manage, Subject
      can :manage, Category
      can :manage, Topic
      can :manage, Guide
      can :manage, Record
      can :manage, Page
      can :manage, User
      can :manage, Responsibility
      can :manage, Redirect
    end
  end
end
