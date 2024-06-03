class RoomsController < ApplicationController

  def index
    @rooms = Room.all

    if params[:start_date].present? && params[:end_date].present?
      @rooms = Room.not_reserved(params[:start_date], params[:end_date])
    end
    @rooms = @rooms.by_location(params[:location]) if params[:location].present?

    @pagy, @rooms = pagy(@rooms)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
    @reservations = Reservation.reserved_dates_room(params[:id])
  end

end
