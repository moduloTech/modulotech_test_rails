# frozen_string_literal: true

module My

  class BookingsController < ApplicationController

    before_action :authenticate_user!
    before_action :find_booking, only: %i[edit update destroy]

    def index
      @bookings = current_user.bookings
    end

    def edit
    end

    def update
      if @booking.update(booking_params)
        return redirect_to(my_bookings_path, flash: { success: t('messages.success') })
      end

      redirect_to(edit_my_booking_path(@booking), flash: { error: @booking.errors.full_messages })
    end

    def destroy
      @booking.destroy

      redirect_to(bookings_url, notice: @booking.errors.first || t('messages.success'))
    end

    private

    def find_booking
      @booking = current_user.bookings.find(params[:id])
    end

    def booking_params
      params.require(:booking).permit(:from, :to)
    end

  end

end
