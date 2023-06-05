class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    return redirect_to room_path(booking_params[:room_id]), flash: { error: t('errors.already_booked') } unless can_book?

    Booking.create booking_params.merge(user: current_user)
    # redirect_to room_path(params[:room_id]), flash: { error: 'Booking failed:' + @booking.errors.full_messages } if @booking.errors.any?

    redirect_to rooms_path, flash: { success: t('messages.booking_success') }
  end

  private

  def booking_params
    params.require(:booking).permit(:room_id, :from, :to)
  end

  def can_book?
    Room.find_by!(booking_params[:room_id]).can_book?(booking_params[:from], booking_params[:to])
  end
end
