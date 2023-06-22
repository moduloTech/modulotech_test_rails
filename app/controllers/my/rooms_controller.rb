class My::RoomsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_room, only: %i[show edit update destroy]

  def index
    @rooms = current_user.rooms
  end

  def show
  end

  def new
    @room = Room.new
  end

  def edit
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to my_room_path(@room), notice: t('rooms.notice.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @room.update(room_params)
      redirect_to my_room_path(@room), notice: t('rooms.notice.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @room.destroy
    redirect_to my_rooms_path, notice: t('rooms.notice.destroyed')
  end

  private

  def set_room
    @room = current_user.rooms.find(params[:id])
  end

  def room_params
    params.require(:room)
          .permit(
            :name, :address, :price_per_night_cents,
            :price_per_night_currency, :rent_per_night_currency, images: []
          )
          .merge(user: current_user)
  end

end
