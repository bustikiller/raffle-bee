class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.blank?
    if user.superadmin?
      can :manage, :all
      can :debug, Riews::View
    elsif user.regular_user?
      can  [:read, :new_sale, :create_sale], Raffle
      can :read, Ticket
    end
  end
end
