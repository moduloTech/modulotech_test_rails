class My::RoomsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_room, only: %i[edit update destroy]

  def index
    @rooms = current_user.rooms
  end

  def new
    @room = Room.new
  end

  def edit
  end

  def create
    @room = current_user.rooms.new(rooms_params)
    return redirect_to(my_rooms_path, notice: t('messages.success')) if @room.save

    redirect_to(new_my_room_path, alert: @room.errors)
  end

  def update
    return redirect_to my_rooms_path if @room.update(rooms_params)

    redirect_to edit_my_room_path, alert: @room.errors
  end

  def destroy
    @room.destroy

    redirect_to my_rooms_path, notice: t('messages.success')
  end

  private

  def set_room
    @room = current_user.rooms.find(params[:id])
  end

  def rooms_params
    params.require(:room).permit(:name, :location, :capacity,
                                 :price_per_night_cents, :image, gallery_images: [])
  end

end
