require 'rails_helper'

RSpec.describe My::RoomsController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns user's rooms to @rooms" do
      room = create(:room, user: user)
      get :index
      expect(assigns(:rooms)).to eq([room])
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "assigns a new room to @room" do
      get :new
      expect(assigns(:room)).to be_a_new(Room)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new room" do
        expect {
          post :create, params: { room: attributes_for(:room) }
        }.to change(Room, :count).by(1)
      end

      it "redirects to my_rooms_path" do
        post :create, params: { room: attributes_for(:room) }
        expect(response).to redirect_to(my_rooms_path)
      end
    end

    context "with invalid params" do
      it "does not create a new room" do
        expect {
          post :create, params: { room: attributes_for(:room, name: nil) }
        }.not_to change(Room, :count)
      end

      it "renders the new template" do
        post :create, params: { room: attributes_for(:room, name: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end


  describe "GET #edit" do
    let(:room) { create(:room, user: user) }

    it "returns http success" do
      get :edit, params: { id: room.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns the requested room to @room" do
      get :edit, params: { id: room.id }
      expect(assigns(:room)).to eq(room)
    end
  end

  describe "PATCH #update" do
    let(:room) { create(:room, user: user) }

    context "with valid params" do
      it "updates the room" do
        patch :update, params: { id: room.id, room: { name: "New Name" } }
        room.reload
        expect(room.name).to eq("New Name")
      end

      it "redirects to my_rooms_path" do
        patch :update, params: { id: room.id, room: { name: "New Name" } }
        expect(response).to redirect_to(my_rooms_path)
      end
    end

    context "with invalid params" do
      it "does not update the room" do
        patch :update, params: { id: room.id, room: { name: nil } }
        room.reload
        expect(room.name).not_to be_nil
      end

      it "renders the edit template" do
        patch :update, params: { id: room.id, room: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:room) { create(:room, user: user) }

    it "destroys the room" do
      expect {
        delete :destroy, params: { id: room.id }
      }.to change(Room, :count).by(-1)
    end

    it "redirects to my_rooms_path" do
      delete :destroy, params: { id: room.id }
      expect(response).to redirect_to(my_rooms_path)
    end
  end
end
