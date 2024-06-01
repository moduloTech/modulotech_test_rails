require 'rails_helper'

RSpec.describe Room, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      room = build(:room)
      expect(room).to be_valid
    end

    it "is not valid without a name" do
      room = build(:room, name: nil)
      expect(room).not_to be_valid
    end

    it "is not valid without a location" do
      room = build(:room, location: nil)
      expect(room).not_to be_valid
    end

    it "is not valid without a capacity" do
      room = build(:room, capacity: nil)
      expect(room).not_to be_valid
    end

    it "is not valid with a non-numeric capacity" do
      room = build(:room, capacity: "not_numeric")
      expect(room).not_to be_valid
    end

    it "is not valid with a capacity less than or equal to 0" do
      room = build(:room, capacity: 0)
      expect(room).not_to be_valid
    end

    it "is not valid without a price per night" do
      room = build(:room, price_per_night_cents: nil)
      expect(room).not_to be_valid
    end

    it "is not valid with a price per night less than or equal to 0" do
      room = build(:room, price_per_night_cents: 0)
      expect(room).not_to be_valid
    end
  end
end
