class RoomsController < ApplicationController

  before_action :set_filters!, only: :index

  def index
    @rooms = Room.all
    filter_rooms!

    @rooms = @rooms.where.not(user: current_user) if current_user.present?
  end

  def show
    scope = current_user.present? ? Room.where.not(user: current_user) : Room.all

    @room = scope.find(params[:id])
    @reservation = Reservation.new
  end

  private

  def set_filters!
    @location = params[:location]
    @check_in = params[:check_in]

    return if @check_in.present? && params[:check_out].present? && params[:check_out] <= @check_in

    @check_out = params[:check_out]
  end

  def filter_rooms!
    @rooms = @rooms.match_by(location: @location) if @location.present?
    @rooms = @rooms.suitable_for_check_in(@check_in).suitable_for_check_out(@check_out)
  end

end
