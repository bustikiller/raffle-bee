class AssignmentsController < ApplicationController
  load_and_authorize_resource :raffle

  def index
    @sellers = @raffle.sales_summary
  end

  def new
  end

  def create
    user = User.find_by email: assignment_params[:email]
    if user
      @raffle.sellers << user
      redirect_to new_raffle_assignment_path(@raffle), notice: 'Vendedor añadido correctamente'
    else
      redirect_to new_raffle_assignment_path(@raffle), alert: 'El usuario no se encuentra en el sistema'
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:email)
  end
end
