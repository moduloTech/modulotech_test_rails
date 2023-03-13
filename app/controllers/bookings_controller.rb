class BookingsController < ApplicationController

  def destroy
    @booking = Booking.find(params[:id])
    redirect_to :action => 'user_bookings' if @booking.delete
  end 

  def create
    @booking = Booking.new(booking_params)
    @room = Room.find(params[:room_id])
    @booking.room_id = @room.id
    @booking.user = current_user
    redirect_to :action => 'user_bookings' if @booking.save
  end

  def user_bookings
    @user_bookings = current_user.bookings.where("checkout >= :date_today", date_today: Date.today)
    @archived_bookings = current_user.bookings.where("checkout < :date_today", date_today: Date.today)
  end

  private

  def booking_params
    params.require(:booking).permit(:checkin, :checkout, :user_id, :room_id, :review, :rating)
  end
end
