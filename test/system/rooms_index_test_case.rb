require "application_system_test_case"

class RoomsIndexTest < ApplicationSystemTestCase
  setup do
    @rooms = rooms
  end

  test "viewing rooms" do
    visit rooms_path
    assert_selector "h1", text: "Rooms"
    @rooms.each do
      assert_text @room.title
    end
  end
end