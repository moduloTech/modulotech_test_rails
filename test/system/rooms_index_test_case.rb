require "application_system_test_case"

class RoomsIndexTest < ApplicationSystemTestCase
  setup do
    @rooms = rooms
  end

  test "viewing rooms" do
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