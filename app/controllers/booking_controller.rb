class BookingsController < ApplicationController
  def new
    authorize @booking
    @animal = Room.find(params[:room_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @room = Room.find(params[:room_id])
    @booking.room_id = @room.id
    @booking.user = current_user
    authorize @booking
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:checkin, :checkout, :user_id, :animal_id, :review, :rating)
  end
end
