require "application_system_test_case"

class RoomsIndexTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @rooms = @user.booked_rooms
  end

  test "viewing rooms" do
    sign_in users(:one)

    visit rooms_path

    assert_selector "h1", text: "Rooms"

    @rooms.each do |room|
      assert_text room.name
      assert_text room.location
      # assert_text room.pictures
      assert_text room.price
    end
  end
end