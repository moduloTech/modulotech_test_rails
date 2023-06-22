class Reservation < ApplicationRecord

  belongs_to :user
  belongs_to :room

  validates :check_in, :check_out, presence: true
  validate :check_in_less_than_check_out
  validate :user_is_not_room_owner

  def check_in_less_than_check_out
    return if check_in && check_in <= check_out

    errors.add(:check_in,
               I18n.t('activerecord.errors.check_in.greater_than_check_out'))
  end

  def user_is_not_room_owner
    errors.add(:user_id, I18n.t('activerecord.errors.user_id.own_room_booking')) if room&.user_id == user_id
  end

end
