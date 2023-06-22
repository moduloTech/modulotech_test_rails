require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  include_context 'with authenticated current_user'

  let(:room1) { create(:room, address: 'Mayfair, London', user: current_user) }
  let(:room2) { create(:room, address: 'Liverpool', user: current_user) }

  describe "GET #index" do
    context 'without params' do
      it "renders the index template with all rooms" do
        get :index

        expect(assigns(:rooms)).to eq([room1, room2])
        expect(response).to render_template(:index)
      end
    end

    context 'with address' do
      it "renders the index template only with closest room" do
        get :index, params: { latitude: 51.51130657591914, longitude: -0.146598815917968, radius: 100 }

        expect(assigns(:rooms)).to eq([room1])
        expect(response).to render_template(:index)
      end
    end
  end

  describe "GET #show" do
    it "assigns room with the requested room" do
      get :show, params: { id: room1.id }

      expect(assigns(:room)).to eq(room1)
      expect(response).to render_template(:show)
    end
  end
end
