class RoomsController < ApplicationController

  def index
    @rooms = Room.all
  end

  def show
    @room           = Room.find(params[:id])
    @booking = Booking.new
    @bookings       = @room.bookings
    @bookings_dates = @bookings.map do |booking|
      {
        from: booking.checkin,
        to:   booking.checkout
      }
    @current_booking = Booking.find_by(user: current_user, room_id: @room)
    end
  end

end
