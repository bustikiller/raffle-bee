class TicketsController < ApplicationController
  load_and_authorize_resource :raffle

  PAGE_SIZE = 100

  def index
    page_number = [params[:page].to_i, 1].max

    @initial_number = PAGE_SIZE * (page_number-1)
    @last_number = @initial_number + PAGE_SIZE - 1
    @tickets = @raffle.tickets.between(@initial_number, @last_number).pluck :number
  end
end
