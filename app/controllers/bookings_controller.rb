class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    @booking = Booking.create booking_params.merge(user: current_user)
    redirect_to room_path(params[:room_id]), flash: { error: 'Booking failed:' + @booking.errors.full_messages } if @booking.errors.any?

    redirect_to rooms_path, flash: { success: 'Congrats! You have booked a room!' }
  end

  def booking_params
    params.require(:booking).permit(:room_id, :from, :to)
  end
end
