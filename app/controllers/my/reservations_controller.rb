class My::ReservationsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_reservation, only: %i[destroy]

  def index
    @status = params[:status]
    @status = Reservation::STATUS[:confirmed] unless Reservation::STATUS.values.include?(@status)

    @reservations = current_user.reservations
    @reservations = @reservations.where(status: @status) if @status.present?
  end

  def create
    @reservation = current_user.reservations.new(reservation_params)
    @room = @reservation.room
    @reservations = Reservation.reserved_dates_room(@room.id)

    if @reservation.save
      redirect_to my_reservations_path, notice: I18n.t('messages.success')
    else
      render turbo_stream: turbo_stream.replace(
        'reservation_form',
        partial: 'my/reservations/form',
        locals:  { room: @room, reservation: @reservation, reservations: @reservations }
      )
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
