class BookingsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    return redirect_to room_path(room_id), flash: { error: t('errors.booking_in_past') } if from < Date.today || to < Date.today
    return redirect_to room_path(room_id), flash: { error: t('errors.to_must_be_above_from') } if to < from
    return redirect_to room_path(room_id), flash: { error: t('errors.already_booked') } unless can_book?

    Booking.create booking_params.merge(user: current_user)
    # redirect_to room_path(params[:room_id]), flash: { error: 'Booking failed:' + @booking.errors.full_messages } if @booking.errors.any?

    redirect_to rooms_path, flash: { success: t('messages.booking_success') }
  end

  private

  def booking_params
    params.require(:booking).permit(:room_id, :from, :to)
  end

  def room_id = booking_params[:room_id].to_i
  def from = booking_params[:from].to_date
  def to = booking_params[:to].to_date

  def can_book?
    Room.find_by!(id: room_id).can_book?(from, to)
  end
end
