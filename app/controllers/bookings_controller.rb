class BookingsController < ApplicationController

  before_action :authenticate_user!

  def index
  end

  def create
    @booking = Booking.create booking_params.merge(user: current_user)
    if @booking.errors.any?
      return redirect_to room_path(booking_params[:room_id].to_i),
                         flash: { error: validation_errors }
    end

    redirect_to rooms_path, flash: { success: t('messages.booking_success') }
  end

  private

  def booking_params
    params.require(:booking).permit(:room_id, :from, :to)
  end

  def validation_errors
    @booking.errors.full_messages
  end

end
