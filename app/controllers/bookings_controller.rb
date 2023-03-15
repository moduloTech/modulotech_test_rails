class BookingsController < ApplicationController

  def create
    @room = Room.find(params[:room_id])
    @booking = Booking.new(booking_params)
    @booking.total_price = (booking_params[:checkout].to_date - booking_params[:checkin].to_date).to_i * @room.price
    @booking.room_id = @room.id
    @booking.user = current_user
    authorize @booking
    redirect_to action: 'user_bookings' if @booking.save
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking
    redirect_to action: 'user_bookings' if @booking.delete
  end

  def user_bookings
    authorize Booking
    @user_bookings = current_user.bookings.current
    @archived_bookings = current_user.bookings.past
  end

  private

  def booking_params
    params.require(:booking).permit(:checkin, :checkout, :user_id, :room_id, :review, :rating)
  end

end
