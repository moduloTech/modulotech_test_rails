class Reservation < ApplicationRecord

  STATUS = {
    pending:   'pending',
    confirmed: 'confirmed',
    canceled:  'canceled'
  }.freeze

  belongs_to :user
  belongs_to :room


  validates :start_date, comparison: { greater_than_or_equal_to: -> { Time.zone.today } }
  validates :end_date, comparison: { greater_than_or_equal_to: ->(reservation) { reservation.start_date } }

  before_validation :set_default_status, on: :create
  validate :can_reserved, if: :dates_and_room_present?, on: :create
  before_validation :calculate_total_price, if: :dates_and_room_present?

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

  def can_reserved
    errors.add(:base, I18n.t('errors.my.reservation.room_reserved')) unless room.reserved?(start_date, end_date)
  end

end
