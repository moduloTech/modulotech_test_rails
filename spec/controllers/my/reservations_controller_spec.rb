require 'rails_helper'

RSpec.describe My::ReservationsController, type: :controller do
  let(:user) { create(:user) }
  let(:room) { create(:room, user: user) }
  let!(:reservation) { create(:reservation, user: user) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns user's reservations to @reservations" do
      get :index
      expect(assigns(:reservations)).to eq([reservation])
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new reservation" do
        expect {
          post :create, params: { reservation: attributes_for(:reservation, room_id: room.id) }
        }.to change(Reservation, :count).by(1)
      end

      it "redirects to my_reservations_path" do
        post :create, params: { reservation: attributes_for(:reservation, room_id: room.id) }
        expect(response).to redirect_to(my_reservations_path)
      end
    end

    context "with invalid params" do
      it "does not create a new reservation" do
        expect {
          post :create, params: { reservation: attributes_for(:reservation, room_id: nil) }
        }.not_to change(Reservation, :count)
      end

      it "renders the 'rooms/show' template" do
        post :create, params: { reservation: attributes_for(:reservation, room_id: nil) }
        expect(response).to render_template("rooms/show")
      end
    end
  end

  describe "DELETE #destroy" do
    it "cancels the reservation" do
      expect {
        delete :destroy, params: { id: reservation.id }
      }.to change { reservation.reload.status }
      .from(Reservation::STATUS[:confirmed])
      .to(Reservation::STATUS[:canceled])
    end

    it "redirects to my_reservations_path" do
      delete :destroy, params: { id: reservation.id }
      expect(response).to redirect_to(my_reservations_path)
    end
  end
end
