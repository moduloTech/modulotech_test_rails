require 'rails_helper'

RSpec.describe My::RoomsController, type: :controller do
  include_context 'with authenticated current_user'

  let(:room) { create(:room, user: current_user) }
  let(:room_params) do
    {
      name: 'Sample Room',
      address: '123 Main St',
      price_per_night_cents: 2000,
      price_per_night_currency: 'USD'
    }
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(assigns(:rooms)).to eq([room])
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, params: { id: room.id }

      expect(assigns(:room)).to eq(room)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: room.id }

      expect(assigns(:room)).to eq(room)
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      subject { post :create, params: { room: room_params } }
      it 'creates a new room' do
        expect {
          subject
        }.to change(Room, :count).by(1)
      end

      it 'redirects to the room show page' do
        subject

        expect(response).to redirect_to(my_room_path(Room.last))
        expect(flash[:notice]).to eq('Room was successfully created.')
      end
    end

    context 'with invalid parameters' do
      subject { post :create, params: { room: { name: nil } } }

      it 'does not create a new room' do
        expect {
          subject
        }.to_not change(Room, :count)
      end

      it 'renders the new template' do
        subject

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      subject { patch :update, params: { id: room.id, room: { name: 'Updated Room Name' } } }

      it 'updates the room' do
        subject

        room.reload
        expect(room.name).to eq('Updated Room Name')
      end

      it 'redirects to the room show page' do
        subject

        expect(response).to redirect_to(my_room_path(room))
        expect(flash[:notice]).to eq('Room was successfully updated.')
      end
    end

    context 'with invalid parameters' do
      subject { patch :update, params: { id: room.id, room: { name: nil } } }

      it 'does not update the room' do
        old_name = room.name

        subject

        room.reload
        expect(room.name).to eq(old_name)
      end

      it 'renders the edit template' do
        subject

        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: room.id } }

    it 'redirects to the rooms index page' do
      subject

      expect(response).to redirect_to(my_rooms_path)
      expect(flash[:notice]).to eq('Room was successfully destroyed.')
    end
  end
end
