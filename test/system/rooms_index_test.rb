require "application_system_test_case"

class RoomsIndexTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @room = rooms(:foo)
  end

  test "viewing rooms as guest" do
    visit rooms_path

    Room.all.each do |room|
      assert_text room.name
      assert_text room.location
      assert_text room.price.to_i
    end
  end

  test "rooms search by location" do
    visit rooms_path(location: @room.location)

    assert_text @room.name
  end

  test "rooms search by date (no booking on those dates)" do
    visit rooms_path(from: Date.today, to: Date.tomorrow)

    assert_text @room.name
  end

  test "rooms search by date (no free rooms)" do
    Booking.create!(room: @room, user: @user, from: Date.today, to: 1.week.since(Date.today))

    visit rooms_path(from: Date.today, to: Date.tomorrow)

    assert_no_text @room.name
  end

  test "booking room as user" do
    sign_in @user
    visit room_path(@room)

    assert_text @room.name

    fill_in 'from', with: Date.today
    fill_in 'to', with: Date.tomorrow

    click_on 'Book it!'

    assert_current_path(rooms_path)
    assert_text I18n.t('messages.booking_success')

    assert { @room.reload.bookings.any? }
  end

end