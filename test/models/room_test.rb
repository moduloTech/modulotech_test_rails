require "test_helper"

class RoomTest < ActiveSupport::TestCase
  setup do
    @room = rooms(:one)
    @user = users(:one)
  end

  test "successfully book room with no bookings" do
    assert @room.can_book?(Date.today, Date.tomorrow)
  end

  test "can't book room already booked on those dates" do
    Booking.create!(user: @user, room: @room, from: Date.today, to: Date.tomorrow)
    assert_not @room.can_book?(Date.today, Date.tomorrow)
  end

  test "can't book room already booked for longer period" do
    Booking.create!(user: @user, room: @room, from: Date.yesterday, to: Date.today + 2.days)
    assert_not @room.can_book?(Date.today, Date.tomorrow)
  end

  test "can't book room when another booking ending within our book period" do
    Booking.create!(user: @user, room: @room, from: Date.today - 1.week, to: Date.tomorrow)
    assert_not @room.can_book?(Date.today, Date.today + 1.week)
  end

  test "can't book room when another booking starting within our book period" do
    Booking.create!(user: @user, room: @room, from: Date.tomorrow, to: Date.today + 1.week)
    assert_not @room.can_book?(Date.today, Date.today + 2.days)
  end
end