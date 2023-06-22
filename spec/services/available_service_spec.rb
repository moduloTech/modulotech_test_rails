require 'rails_helper'

RSpec.describe Rooms::AvailableService, type: :service do
  subject { Rooms::AvailableService.call(params) }

  let(:latitude) { 38.7912984 }
  let(:longitude) { -9.202429 }
  let(:check_in) { Date.today }
  let(:check_out) { Date.tomorrow }

  let(:user)  { create :user }
  let(:room1) { create(:room, address: 'Odivelas, Lisbon', user: user) }
  let(:room2) { create(:room, address: 'London', user: user) }

  before do
    room1
    room2
  end

  describe '#call' do
    context 'with latitude and longitude params' do
      let(:params) { { latitude: latitude, longitude: longitude, radius: 100 } }

      it 'returns rooms near the specified location' do
        expect(subject).to include(room1)
        expect(subject).not_to include(room2)
      end
    end

    context 'with check-in and check-out params' do
      let(:reservation1) { create(:reservation, room: room1, check_in: check_in, check_out: check_out) }

      before do
        reservation1
      end

      let(:params) { { check_in: check_in, check_out: check_out } }

      it 'returns rooms that are available within the specified date range' do
        expect(subject).to include(room2)
        expect(subject).not_to include(room1)
      end
    end

    context 'without any params' do
      let(:params) { {} }

      it 'returns all rooms' do
        expect(subject).to include(room1, room2)
      end
    end
  end
end
