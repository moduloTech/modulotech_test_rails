class My::ReservationsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_reservation, only: %i[destroy]

  def index
    @reservations = current_user.reservations
  end

  def create
    @reservation = current_user.reservations.new(reservation_params)
    @room = @reservation.room
    @reservations = Reservation.reserved_dates_room(@room.id)

    if @reservation.save
      redirect_to my_reservations_path, notice: I18n.t('messages.success')
    else
      respond_to do |format|
        format.html { render 'rooms/show', status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "reservation_form",
            partial: 'my/reservations/reservation_form',
            locals: { room: @room, reservation: @reservation, reservations: @reservations }
          )
        end
      end
    end
  end

  def destroy
    @reservation.cancel!

    redirect_to my_reservations_path, notice: I18n.t('messages.success')
  end

  private

  def set_reservation
    @reservation = current_user.reservations.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :room_id)
  end

end
