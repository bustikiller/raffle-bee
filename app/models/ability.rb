class Ability
  include CanCan::Ability

  def initialize(user)
    if user.superadmin?
      can :manage, :all
    end
  end
end
