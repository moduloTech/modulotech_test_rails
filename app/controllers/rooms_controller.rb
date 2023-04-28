class RoomsController < ApplicationController

  def index
    @rooms = Room.all

    if params[:start_date].present? && params[:end_date].present?
      @rooms = Room.free_on(params[:start_date], params[:end_date])
    end

    return if params[:location].blank?

    @rooms = @rooms.joins(:address).where('addresses.city ILIKE ?', "%#{params[:location]}%")
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
    @room.build_address
  end

  def edit
    @room = Room.find params[:id]
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to @room, notice: t('rooms.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    room = Room.find(params[:id])
    room.update!(room_params)
    redirect_to room
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    redirect_to my_rooms_url, notice: t('rooms.deleted')
  end

  def my_rooms
    @rooms = current_user.rooms
  end

  private

  def room_params
    params.require(:room).permit(:user_id, :name, :price, images: [], address_attributes: %i[city street])
  end

end
