class Reservation < ApplicationRecord

  STATUS = {
    pending:   'pending',
    confirmed: 'confirmed',
    canceled:  'canceled'
  }.freeze

  belongs_to :user
  belongs_to :room

  validates :start_date, :end_date, presence: true

  before_validation :set_default_status, on: :create
  before_validation :calculate_total_price, if: :dates_and_room_present?
  validate :dates_in_past, :end_above_start_date, :can_reserved, if: :dates_and_room_present?, on: :create

  scope :reserved, lambda { |start_date, end_date|
                     where(start_date: ..end_date, end_date: start_date..)
                       .where.not(status: STATUS[:canceled])
                   }

  scope :reserved_dates_room, lambda { |room_id|
    where(room_id:).where.not(status: STATUS[:canceled]).order(start_date: :asc).pluck(:start_date, :end_date)
  }

  def cancel!
    update(status: STATUS[:canceled])
  end

  def confirmed?
    status == STATUS[:confirmed]
  end

  private

  # Skip status, for the confirmation reservation
  # Owner of the room should be able to confirm the reservation
  def set_default_status
    self.status = STATUS[:confirmed]
  end

  def dates_and_room_present?
    start_date.present? && end_date.present? && room.present?
  end

  def calculate_total_price
    self.price_cents = (end_date - start_date + 1).to_i * room.price_per_night_cents
  end

  def dates_in_past
    errors.add(:base, I18n.t('errors.my.reservation_in_past')) if Time.zone.today > start_date.to_date
  end

  def end_above_start_date
    errors.add(:base, I18n.t('errors.my.reservation.end_date_before_start_date')) if end_date < start_date
  end

  def can_reserved
    errors.add(:base, I18n.t('errors.my.reservation.room_reserved')) unless room.reserved?(start_date, end_date)
  end

end
