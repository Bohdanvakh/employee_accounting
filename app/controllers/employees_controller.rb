class EmployeesController < ApplicationController
  before_action :find_employee, only: [:edit, :update, :destroy]

  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find(params[:id]).decorate

    @vacation = Vacation.new
    @vacations = @employee.vacations
    @total_vacation_days = @employee.total_vacation_days
    @salary = @employee.calculate_salary

    @position_history = PositionHistory.new
    @position = @employee.position_histories.last
    @position_histories = @employee.position_histories
    @last_position = @employee.last_position
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to @employee
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      redirect_to @employee
    else
      render :edit
    end
  end

  def destroy
    @employee.destroy
  end

  private

  def find_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:first_name, :middle_name, :last_name, :passport_data, :date_of_birth, :place_of_birth, :home_address, :department_id)
  end
end
