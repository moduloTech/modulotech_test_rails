class BookingsController < ApplicationController

  before_action :authenticate_user!

  def create
    @booking = current_user.bookings.new(booking_params)
    if @booking.save
      redirect_to(rooms_path, flash: { success: t('messages.booking_success') })
    else
      error = @booking.errors.full_messages
      redirect_to(room_path(booking_params[:room_id].to_i), flash: { error: })
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    return t('errors.not_user_booking') unless @booking.room.user_id == current_user.id

    @booking.destroy
    error = @booking.errors.full_messages
    redirect_to(my_room_path(@booking.room_id), notice: error || t('messages.success'))
  end

  private

  def booking_params
    params.require(:booking).permit(:room_id, :from, :to)
  end

end
