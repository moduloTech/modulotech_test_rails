class Room < ApplicationRecord

  belongs_to :user

  has_many_attached :images

  validates :name, :location, :price_per_night, :start_date, :end_date, presence: true
  validates :price_per_night, numericality: { greater_than: 0 }

  validate :check_dates

  scope :suitable_for_check_in, lambda { |start_date|
    where(start_date: ..start_date, end_date: start_date..) if start_date.present?
  }

  scope :suitable_for_check_out, lambda { |end_date|
    where(start_date: ..end_date, end_date: end_date..) if end_date.present?
  }

  private

  def check_dates
    return if start_date.nil? || end_date.nil?

    errors.add(:base, t('models.room.check_dates')) if start_date >= end_date
  end

end
