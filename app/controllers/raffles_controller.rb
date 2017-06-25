class RafflesController < ApplicationController
  load_and_authorize_resource

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
  end

  def index
    @raffles = Raffle.accessible_by current_ability
  end

  def destroy
  end

  def show
  end

  private

  def raffle_params
    params.require(:raffle).permit(:id, :name, :starts_on, :ends_on, :max_number_of_tickets, :price)
  end
end
