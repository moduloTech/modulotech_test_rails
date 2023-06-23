class RoomsController < ApplicationController

  def index
    @rooms = Rooms::AvailableService.call(search_params)
  end

  def show
    @room = Room.find(params[:id])
  end

  private

  def search_params
    params.permit(:check_in, :check_out, :latitude, :longitude, :radius)
  end

end
