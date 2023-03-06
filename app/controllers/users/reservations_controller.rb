module Users

  class ReservationsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_reservation, only: %i[edit update destroy]

    def index
      @reservations = Reservation.where(user: current_user)
    end

    def edit
    end

    def create
      @reservation = Reservation.new(reservation_params) do |reservation|
        reservation.room_id = params[:room_id]
        reservation.user = current_user
      end

      if @reservation.save
        redirect_to(my_reservations_path, notice: t('.success'))
      else
        redirect_to(room_path(params[:room_id]), alert: t('.failed'))
      end
    end

    def update
      if @reservation.update(reservation_params)
        redirect_to(my_reservations_path, notice: t('.success'))
      else
        render(:edit, status: :unprocessable_entity)
      end
    end

    def destroy
      return if @reservation.user_id != current_user.id

      if @reservation.destroy
        redirect_to(my_reservations_path, notice: t('.success'))
      else
        redirect_to(my_reservations_path, alert: t('.failed'))
      end
    end

    private

    def set_reservation
      @reservation = Reservation.where(user: current_user).find(params[:id])
    end

    def reservation_params
      params.require(:reservation).permit(:check_in, :check_out)
    end

  end

end
