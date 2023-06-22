module Rooms

  class AvailableService < ApplicationService

    DEFAULT_RADIUS = 50

    def initialize(params)
      super()
      @params = params
    end

    def call
      rooms = Room.all

      if @params[:latitude].present? && @params[:longitude].present?
        rooms = rooms.near([@params[:latitude], @params[:longitude]], radius)
      end

      if @params[:check_in].present? && @params[:check_out].present?
        rooms = rooms.free(@params[:check_in], @params[:check_out])
      end

      rooms
    end

    private

    def radius
      @params[:radius].presence || DEFAULT_RADIUS
    end

  end

end
