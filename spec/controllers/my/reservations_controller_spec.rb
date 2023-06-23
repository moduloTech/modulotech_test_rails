require 'rails_helper'

RSpec.describe My::ReservationsController, type: :controller do
  include_context 'with authenticated current_user'

  let(:room) { create(:room, user: user) }
  let(:user) { create(:user) }
  let(:reservation) { create(:reservation, user: current_user, room: room) }
  let(:reservation_params) { { reservation: { room_id: room.id, check_in: Date.today, check_out: Date.tomorrow } } }

  describe 'GET #index' do
    it 'renders the index template' do
      reservation

      get :index
      expect(assigns(:reservations)).to eq([reservation])
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, params: { id: reservation.id }
      expect(assigns(:reservation)).to eq(reservation)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: reservation.id }
      expect(response).to render_template(:edit)
      expect(assigns(:reservation)).to eq(reservation)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      subject { post :create, params: reservation_params }

      it 'creates a new reservation' do
        expect {
          subject
        }.to change(Reservation, :count).by(1)
      end

      it 'redirects to the reservation show page' do
        subject

        expect(response).to redirect_to(my_reservation_path(Reservation.last))
        expect(flash[:notice]).to eq('Reservation was successfully created.')
      end
    end

    context 'with invalid parameters' do
      subject { post :create, params: { reservation: { room_id: nil } } }

      it 'does not create a new reservation' do
        expect {
          subject
        }.to_not change(Reservation, :count)
      end

      it 'makes an alert' do
        subject

        expect(flash[:alert]).to eq("Room must exist, Check In can't be blank, Check Out can't be blank, Check In must be less than check out")
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      subject { patch :update, params: { id: reservation.id, reservation: { check_in: Date.today + 1 } } }

      it 'updates the reservation' do
        subject

        reservation.reload
        expect(reservation.check_in).to eq(Date.today + 1)
      end

      it 'redirects to the reservation show page' do
        subject

        expect(response).to redirect_to(my_reservation_path(reservation))
        expect(flash[:notice]).to eq('Reservation was successfully updated.')
      end
    end

    context 'with invalid parameters' do
      subject { patch :update, params: { id: reservation.id, reservation: { check_in: nil } } }

      it 'does not update the reservation' do
        old_check_in = reservation.check_in

        subject

        reservation.reload
        expect(reservation.check_in).to eq(old_check_in)
      end

      it 'renders the edit template' do
        subject

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: reservation.id } }

    it 'redirects to the reservations index page' do
      subject

      expect(response).to redirect_to(my_reservations_path)
      expect(flash[:notice]).to eq('Reservation was successfully destroyed.')
    end
  end
end
