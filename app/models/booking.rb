class Booking < ApplicationRecord

  scope :booked, ->(from, to) { where(to: from.., from: ..to) }

  belongs_to :room
  belongs_to :user

  validates :from, :to, presence: true

  validate :dates_in_past, :to_above_from, :can_book

  private

  def dates_in_past
    add_error I18n.t('errors.booking_in_past') if Time.zone.today > to.to_date
  end

  def to_above_from
    add_error I18n.t('errors.to_must_be_above_from') if to < from
  end

  def can_book
    add_error I18n.t('errors.already_booked') unless room.can_book?(from, to)
  end

  def add_error(msg) = errors.add :base, :invalid, message: msg

end
