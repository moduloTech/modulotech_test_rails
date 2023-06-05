require "test_helper"

class RoomTest < ActiveSupport::TestCase
  setup do
    @room = rooms(:one)
    @user = users(:one)

    base_date = Date.today
    @date_in_past = base_date
    @date_in_future = 1.week.since(base_date)

    @today = base_date + 1.day
    @tomorrow = base_date + 2.days
  end

  test "successfully book room with no bookings" do
    assert @room.can_book?(@today, @tomorrow)
  end

  test "can't book room already booked on those dates" do
    Booking.create!(user: @user, room: @room, from: @today, to: @tomorrow)
    assert_not @room.can_book?(@today, @tomorrow)
  end

  test "can't book room already booked for longer period" do
    Booking.create!(user: @user, room: @room, from: @date_in_past, to: @date_in_future)
    assert_not @room.can_book?(@today, @tomorrow)
  end

  test "can't book room when another booking ending within our book period" do
    Booking.create!(user: @user, room: @room, from: @date_in_past, to: @tomorrow)
    assert_not @room.can_book?(@today, @date_in_future)
  end

  test "can't book room when another booking starting within our book period" do
    Booking.create!(user: @user, room: @room, from: @tomorrow, to: @date_in_future)
    assert_not @room.can_book?(@today, @date_in_future)
  end
end