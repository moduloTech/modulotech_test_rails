# reservation_spec.rb
require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      reservation = build(:reservation)
      expect(reservation).to be_valid
    end

    it 'is not valid without start_date' do
      reservation = build(:reservation, start_date: nil)
      expect(reservation).not_to be_valid
    end

    it 'is not valid without end_date' do
      reservation = build(:reservation, end_date: nil)
      expect(reservation).not_to be_valid
    end

    it 'is not valid when start_date is in the past' do
      reservation = build(:reservation, start_date: Time.zone.today - 1)
      expect(reservation).not_to be_valid
    end

    it 'is not valid when end_date is before start_date' do
      reservation = build(:reservation, start_date: Time.zone.today, end_date: Time.zone.today - 1)
      expect(reservation).not_to be_valid
    end

    it 'is not valid when room is already reserved' do
      room = create(:room)
      create(:reservation, room:, start_date: Time.zone.today, end_date: Time.zone.today + 1)
      reservation = build(:reservation, room:, start_date: Time.zone.today, end_date: Time.zone.today + 1)
      expect(reservation).not_to be_valid
    end
  end

  describe '#cancel!' do
    it 'updates the status to canceled' do
      reservation = create(:reservation)
      reservation.cancel!
      expect(reservation.status).to eq('canceled')
    end
  end

  describe '#confirmed?' do
    it 'returns true if status is confirmed' do
      reservation = build(:reservation, status: 'confirmed')
      expect(reservation).to be_confirmed
    end

    it 'returns false if status is not confirmed' do
      reservation = build(:reservation, status: 'pending')
      expect(reservation).not_to be_confirmed
    end
  end
end
