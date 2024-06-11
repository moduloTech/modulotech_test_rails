class My::RoomsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_room, only: %i[show edit update destroy]

  def index
    @rooms = current_user.rooms
  end

  def show
    @reservations = @room.reservations
    render turbo_stream: turbo_stream.replace(
      'room_reservations',
      partial: 'my/rooms/reservations',
      locals:  { room: @room, reservations: @reservations }
    )
  end

  def new
    @room = Room.new
  end

  def edit
  end

  def create
    @room = current_user.rooms.new(rooms_params)
    return render(:new, status: :unprocessable_entity) unless @room.save

    redirect_to my_rooms_path, notice: I18n.t('messages.success')
  end

  def update
    return render(:edit, status: :unprocessable_entity) unless @room.update(rooms_params)

    redirect_to my_rooms_path, notice: I18n.t('messages.success')
  end

  def destroy
    @room.destroy

    redirect_to my_rooms_path, notice: I18n.t('messages.success')
  end

  def remove_image
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge_later
    redirect_back(fallback_location: request.referer)
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
