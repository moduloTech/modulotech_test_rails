class ReservationsController < ApplicationController

  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      redirect_to my_reservations_url, notice: t('reservations.created')
    else
      redirect_to room_path(reservation_params[:room_id]), status: :unprocessable_entity, alert: t('reservations.error')
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy

    redirect_to my_reservations_url, notice: t('reservations.deleted')
  end

  private

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :user_id, :room_id)
  end

end
