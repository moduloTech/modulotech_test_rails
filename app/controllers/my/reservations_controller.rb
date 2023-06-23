class My::ReservationsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_reservation, only: %i[show edit update destroy]

  def index
    @reservations = Reservation.includes(:room).where(user: current_user)
  end

  def show
  end

  def edit
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      redirect_to my_reservation_path(@reservation), notice: t('reservations.notice.created')
    else
      redirect_to rooms_path, status: :unprocessable_entity, alert: @reservation.errors.full_messages.join(', ')
    end
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to my_reservation_path(@reservation), notice: t('reservations.notice.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
    redirect_to my_reservations_path, notice: t('reservations.notice.destroyed')
  end

  private

  def set_reservation
    @reservation = current_user.reservations.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:room_id, :check_in, :check_out)
          .merge(user: current_user)
  end

end
