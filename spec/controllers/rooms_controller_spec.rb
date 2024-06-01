require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      room = create(:room)
      get :show, params: { id: room.id }
      expect(response).to have_http_status(:success)
    end
  end
end
