class PositionsController < ApplicationController
  before_action :find_position, only: [:show, :edit, :update, :destory]

  def index
    @positions = Position.all
  end

  def show
  end

  def new
    @position = Position.new
  end

  def create
    position = Position.create(position_params)
    if position.save
      redirect_to position
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @position.update(position_params)
      redirect_to @position
    else
      render :edit
    end
  end

  def destroy
    @position.destroy
  end

  private

  def find_position
    @position = Position.find(params[:id])
  end

  def position_params
    params.require(:position).permit(:name, :salary, :vacation_days)
  end
end
