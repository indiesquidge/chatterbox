class RoomsController < ApplicationController
  respond_to :json, :html

  def index
   @room = Room.new(name: rand(9999))
   @room.choices << Choice.new(title: rand(9999))
   @room.choices << Choice.new(title: rand(9999))
   @room.save
   @messages = @room.messages

   render :show
  end
  def create
    room = Room.new(room_params)
    params[:room][:choices].each { |choice| room.choices.build(title: choice) }
    if room.save
      room.update!(user_id: current_user.id)
      respond_with room
    else
      head :bad_request
    end
  end

  def show
    @room = Room.find_by(slug: params[:slug])
    @messages = @room.messages
  end

  def update
    room = Room.find_by(slug: params[:slug])
    room.update!(state: "closed")
    room.random_choice.update!(chosen: true)

    redirect_to :back
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
