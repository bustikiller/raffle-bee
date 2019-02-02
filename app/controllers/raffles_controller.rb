class RafflesController < ApplicationController
  load_and_authorize_resource

  before_action :load_resource, only: [:new_sale, :create_sale, :search]

  def new
  end

  def create
    @raffle.owner = current_user
    if @raffle.save
      redirect_to raffles_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @raffle.owner = current_user
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
    @ticket = @raffle.tickets.build
  end

  def create_sale
    @ticket = @raffle.tickets.build ticket_params
    @ticket.user = current_user
    if @ticket.valid?
      amount = [@ticket.amount.to_i, 1].max
      numbers_bought = @raffle.sell_several_tickets @ticket, amount
      MailerService.new.deliver(
          name: @ticket.name,
          raffle: @raffle,
          email: @ticket.email,
          tickets: numbers_bought
      )
      redirect_to raffle_path(@raffle), notice: "Se han vendido #{amount} papeletas a #{@ticket.name}: #{numbers_bought.join(', ')}"
    else
      render :new_sale
    end
  end

  def search
    @ticket = @raffle.tickets.where(number: params['number']).limit(1).select(:name, :email).first
  end

  private

  def raffle_params
    params.require(:raffle).permit(:id, :name, :starts_on, :ends_on, :max_number_of_tickets, :price, :award)
  end

  def ticket_params
    params.require(:ticket).permit(:name, :email, :amount)
  end

  def load_resource
    @raffle = Raffle.find params['raffle_id']
  end
end
