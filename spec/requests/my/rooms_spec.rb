require 'rails_helper'

RSpec.describe "My::Rooms", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/my/rooms/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/my/rooms/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/my/rooms/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/my/rooms/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/my/rooms/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/my/rooms/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
