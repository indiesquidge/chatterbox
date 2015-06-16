class RoomsController < ApplicationController
  def new
  end

  def create
    room = Room.new(room_params)
    if room.save
      redirect_to room_path(room)
    else
      flash[:error] = "An error prevented your room from being saved."
      redirect_to root_path
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end