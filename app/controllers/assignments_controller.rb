class AssignmentsController < ApplicationController
  load_and_authorize_resource :raffle

  def index
    @sellers = @raffle.tickets.left_joins(:user).group('users.email').count.sort_by{|_k,v| v}.reverse
  end
end
