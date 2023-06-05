class RoomsController < ApplicationController
  def index
    @rooms = Room.all

    if params[:from].present? && params[:to].present?
      @rooms = Room.not_booked(params[:from], params[:to])
    end

    @rooms = @rooms.where(location: params[:location]) if params[:location].present?
  end

  def show
    @room = Room.find_by!(id: params[:id])
  end
end
