require "application_system_test_case"

class RoomsIndexTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @rooms = Room.all
  end

  test "viewing rooms as guest" do
    visit rooms_path

    @rooms.each do |room|
      assert_text room.name
      assert_text room.location
      assert_text room.price.to_i
    end
  end

  test "rooms search by location" do
    room = rooms(:foo)
    visit rooms_path(location: room.location)

    assert_text room.name
  end
  # test "viewing rooms as user" do
  #   sign_in @user
  #   visit rooms_path
  #
  #   @rooms.each do |room|
  #     assert_text room.name
  #     assert_text room.location
  #     # assert_text room.pictures
  #     assert_text room.price
  #   end
  # end

end