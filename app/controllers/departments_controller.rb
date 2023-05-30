class DepartmentsController < ApplicationController
  before_action :find_department, only: [:show, :edit, :update, :destroy]

  def index
    @departments = Department.all
  end

  def show
    @employees = @department.employees
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      redirect_to @department
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @department.update(department_params)
      redirect_to @department
    else
      render :edit
    end
  end

  def destroy
    @department.destroy
  end

  private

  def find_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name, :abbreviation)
  end
end
