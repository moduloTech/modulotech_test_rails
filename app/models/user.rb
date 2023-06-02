class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :bookings

  def booked_rooms
    # Выбрать все записи из Bookings
    # где дата начала (from) between start_date..end_date,
    # ИЛИ дата конца (to) between start_date..end_date
    bookings.where()
  end

end
