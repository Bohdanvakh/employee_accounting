class PositionsController < ApplicationController
  def index
    @positions = Position.all
  end

  def show
    @position = Position.find(params[:id])
  end

  def new
    @position = Position.new
  end

  def create
    @position = Position.create(position_params)
    if @position.save
      redirect_to @position
    else
      render :new
    end
  end

  def edit
    @position = Position.find(params[:id])
  end

  def update
    @position = Position.find(params[:id])
    if @position.update(position_params)
      redirect_to @position
    else
      render :edit
    end
  end

  def destroy
    @position = Position.find(position[:id])
    @position.destroy
  end

  private
  def position_params
    params.require(:position).permit(:name, :salary, :vacation_days)
  end
end
