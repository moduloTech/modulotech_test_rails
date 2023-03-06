class Reservation < ApplicationRecord

  belongs_to :user
  belongs_to :room

  validates :check_in, :check_out, presence: true
  validates :room_id, uniqueness: { scope: :user_id }
  validate :check_dates, :check_availability

  private

  def check_dates
    return if check_in.nil? || check_out.nil?

    errors.add(:base, I18n.t('models.reservation.check_dates')) if check_in >= check_out
  end

  def check_availability
    return if check_in.nil? || check_out.nil?

    if check_in < room.start_date || check_in >= room.end_date
      errors.add(:base, I18n.t('models.reservation.incorrect_check_in'))
    end

    return if check_out > room.start_date && check_out <= room.end_date

    errors.add(:base, I18n.t('models.reservation.incorrect_check_out'))
  end

end
