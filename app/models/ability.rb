class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user.present? # = unless user.nil? 
      can :manage, Post, user_id: user.id
      can :update, User, id: user.id
      can :follow, User do |u| #u : 팔로우 대상
        u != user # user : 현재 유저
      end
      if user.has_role?(:admin)
        #user가 admin 역할을 가지고 있으면
        can :mange, :all 
        #전부 다 관리 가능하다.(CRUD)
      end
    end
    
    #이 게시물의 권한이 있을 시 네가지 활동을 할 수 있음
    
    
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
