module Users

  class ImagesController < ApplicationController

    before_action :authenticate_user!

    def destroy
      room = Room.find(params[:my_room_id])
      return unless room.user_id == current_user.id

      room.images.find_by(id: params[:id])&.purge

      redirect_to(my_room_path(room), notice: t('.success'))
    end

  end

end
