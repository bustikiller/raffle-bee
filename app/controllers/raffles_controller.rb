class RafflesController < ApplicationController
  load_and_authorize_resource

  before_action :load_resource, only: [:new_sale, :create_sale]

  def new
  end

  def create
    @raffle.user = current_user
    if @raffle.save
      redirect_to raffles_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @raffle.user = current_user
    if @raffle.update(raffle_params)
      redirect_to raffles_path
    else
      render :edit
    end
  end

  def index
    @raffles = Raffle.accessible_by current_ability
  end

  def destroy
  end

  def show
  end

  def new_sale
    authorize! :sell, @raffle
    binding.pry unless @raffle
    @ticket = @raffle.tickets.build
  end

  def create_sale
    authorize! :sell, @raffle
    @ticket = @raffle.tickets.build ticket_params
    @ticket.user = current_user
    if @ticket.valid?
      amount = [@ticket.amount.to_i, 1].max
      numbers_bought = @raffle.sell_several_tickets @ticket, amount
      MailerService.new.send(
          name: @ticket.name,
          email: @ticket.email,
          tickets: numbers_bought
      )
      redirect_to raffle_tickets_path(@raffle)
    else
      render :new_sale
    end
  end

  private

  def raffle_params
    params.require(:raffle).permit(:id, :name, :starts_on, :ends_on, :max_number_of_tickets, :price)
  end

  def ticket_params
    params.require(:ticket).permit(:name, :email, :amount)
  end

  def load_resource
    @raffle = Raffle.find params['raffle_id']
  end
end
