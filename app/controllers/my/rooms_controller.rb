# frozen_string_literal: true

module My

  class RoomsController < ApplicationController

    before_action :authenticate_user!
    before_action :find_room, only: %i[show edit update destroy]

    def index
      @rooms = current_user.rooms
    end

    def show
      @bookings = @room.bookings
    end

    def new
      @room = Room.new
    end

    def edit
    end

    def create
      @room = current_user.rooms.new(rooms_params)

      redirect_to(my_rooms_path, notice: t('messages.success')) and return if @room.save

      redirect_to(new_my_room_path, alert: @room.errors)
    end

    def update
      redirect_to my_room_path(@room) and return if @room.update(rooms_params)

      redirect_to edit_my_room_path, alert: @room.errors
    end

    def destroy
      @room.destroy

      redirect_to my_rooms_path, notice: @room.errors.first || t('messages.success')
    end

    private

    def find_room
      @room = current_user.rooms.find(params[:id])
    end

    def rooms_params
      params.require(:room).permit(:name, :description, :price_cents, :location, images: [])
    end

  end

end
