class VacationsController < ApplicationController
  def new
    @employee = Employee.find_by(params[:id])
    @vacation = @employee.vacations.build
  end

  def create
    @employee = Employee.find(params[:employee_id])
    @vacation = Vacation.new(vacation_params)

    if @vacation.valid?
      @vacation.save
      redirect_to employee_path(@employee)
    else
      flash[:vacation_errors] = @vacation.errors.full_messages
      redirect_to employee_path(@employee)
    end
  end

  private

  def vacation_params
    params.require(:vacation).permit(:started_on, :finished_on, :employee_id)
  end
end
