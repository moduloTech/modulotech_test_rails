class RoomsController < ApplicationController

  def index
    @rooms = Room.all

    if params[:from].present? && params[:to].present?
      @rooms = Room.not_booked(params[:from], params[:to])
    end

    return if params[:location].blank?

    @rooms = @rooms.where('location ILIKE ?', "%#{params[:location]}%")
  end

  def show
    @room = Room.find(params[:id])
  end

end
