module Users

  class RoomsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_room, except: %i[index new create]

    def index
      @rooms = Room.where(user: current_user)
    end

    def show
      @new_image = ActiveStorage::Attachment.new
    end

    def new
      @room = Room.new
    end

    def edit
    end

    def create
      @room = Room.new(room_params) { |room| room.user = current_user }

      if @room.save
        redirect_to(my_rooms_path, notice: t('.success'))
      else
        render(:new, status: :unprocessable_entity)
      end
    end

    def update
      if @room.update(room_params)
        redirect_to(my_room_path(@room), notice: t('.success'))
      else
        render(:edit, status: :unprocessable_entity)
      end
    end

    def destroy
      return if @room.user_id != current_user.id

      if @room.destroy
        redirect_to(my_rooms_path, notice: t('.success'))
      else
        redirect_to(my_room_path(@room), alert: t('.failed'))
      end
    end

    private

    def room_params
      params.require(:room).permit(
        :name, :location, :price_per_night, :start_date, :end_date, images: []
      )
    end

    def set_room
      @room = Room.where(user: current_user).find(params[:id])
    end

  end

end
