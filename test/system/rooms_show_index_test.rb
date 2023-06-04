require "application_system_test_case"

class RoomsShowTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "view some room as guest" do
    room = rooms(:one)
    visit rooms_path(room)

    assert_text room.name
    assert_text room.location
    assert_text room.price
  end
end