class PositionHistoriesController < ApplicationController
  def new
    @employee = Employee.find(params[:employee_id])
    @position_history = @employee.position_histories.build
  end

  def create
    @employee = Employee.find(params[:employee_id])
    @position_history = @employee.position_histories.build(position_history_params)
    if @position_history.save
      redirect_to employee_path(@employee)
    else
      render :new
    end
  end

  private

  def position_history_params
    params.require(:position_history).permit(:position_id, :started_on, :finished_on)
  end
end
