class PositionHistoriesController < ApplicationController
  before_action :find_position_history, only: [:new, :create, :update]

  def new
    @position_history = @employee.position_histories.build
  end

  def create
    @position_history = PositionHistory.new(position_history_params)

    if @position_history.save
      redirect_to employee_path(@employee)
    else
      flash[:position_errors] = @position_history.errors.full_messages
      redirect_to employee_path(@employee)
    end
  end

  def edit
    @position_history = PositionHistory.find(params[:id])
  end

  def update
    @position_history = PositionHistory.find(params[:id])

    if @position_history.update(position_history_params)
      redirect_to employee_path(@employee)
    else
      render :edit
    end
  end

  private

  def find_position_history
    @employee = Employee.find(params[:employee_id])
  end

  def position_history_params
    params.require(:position_history).permit(:position_id, :employee_id, :started_on, :finished_on)
  end
end
