class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.blank?
    if user.superadmin?
      can :manage, :all
      can :debug, Riews::View
      can :index, Assignment, raffle_id: user.raffles.pluck(:id)
    elsif user.regular_user?
      can  [:read, :new_sale, :create_sale], Raffle, id: user.assignments.pluck(:raffle_id)
      can :read, Ticket
      can :manage, Assignment, raffle_id: user.raffles_owned.pluck(:id)
    end
  end
end
