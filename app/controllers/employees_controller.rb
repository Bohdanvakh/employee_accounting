class EmployeesController < ApplicationController
  before_action :find_employee, only: [:show, :edit, :update, :destroy]

  require 'employee_decorator'

  def index
    @employees = Employee.all
  end

  def show
    @decorator_employee = EmployeeDecorator.new(@employee)

    @vacation = Vacation.new
    @vacations = @employee.vacations
    @vacation_days = @employee.vacation_days
    @used_vacation_days = @employee.used_vacation_days
    @remaining_vacation_days = @employee.remaining_vacation_days

    @position_history = PositionHistory.new
    @position = @employee.position_histories.last
    @position_histories = @employee.position_histories

    @total_vacation_days = @employee.vacations.sum { |vacation| (vacation.finished_on - vacation.started_on).to_i }
    @salary = @decorator_employee.calculate_salary
  end

  def new
    @employee = Employee.new
  end

  def create
    employee = Employee.new(employee_params)
    if employee.save
      redirect_to employee
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
