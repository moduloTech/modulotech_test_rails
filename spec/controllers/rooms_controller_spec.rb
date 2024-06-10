require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  let(:room) { create(:room) }

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    context 'with location filter' do
      it 'filters rooms by location' do
        room_in_location = create(:room, location: 'Paris')
        room_outside_location = create(:room, location: 'London')

        get :index, params: { location: 'Paris' }
        expect(assigns(:rooms)).to include(room_in_location)
        expect(assigns(:rooms)).not_to include(room_outside_location)
      end
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: room.id }
      expect(response).to have_http_status(:success)
    end

    it 'assigns a new reservation' do
      get :show, params: { id: room.id }
      expect(assigns(:reservation)).to be_a_new(Reservation)
    end

    it 'assigns reservations for the room' do
      reservation = create(:reservation, room:)
      get :show, params: { id: room.id }
      expect(assigns(:reservations)).to include([reservation.start_date, reservation.end_date])
    end
  end
end
