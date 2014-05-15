require 'spec_helper'

describe Mongoid::Scribe::DocumentsController do

  routes { Mongoid::Scribe::Engine.routes }

  let!(:user) { FactoryGirl.create(:user) }
  let!(:address) { FactoryGirl.create(:address, user: user) }

  describe "all" do
    it "renders successfully" do
      get :all

      expect(response).to be_success
    end
  end

  describe "index" do
    it "lists all the records for the type" do
      get :index, type: "user"

      expect(response).to be_success
      expect(assigns(:klass)).to eq(User)
      expect(assigns(:documents)).to include(user)
    end
  end

  describe "show" do
    it "displays a record" do
      get :show, type: "user", id: user.id

      expect(response).to be_success
      expect(assigns(:klass)).to eq(User)
      expect(assigns(:document)).to eq(user)
      expect(response.body).to match /#{address.id}/
    end
  end

  describe "edit" do
    it "displays a record to edit" do
      get :edit, type: "user", id: user.id

      expect(response).to be_success
      expect(assigns(:klass)).to eq(User)
      expect(assigns(:document)).to eq(user)
    end
  end

  describe "update" do
    it "updates a record" do
      put :update, type: "user", id: user.id, user: {first_name: "First", last_name: "Last", email: "user@example.com"}

      expect(response).to redirect_to(document_path("user", user.id))
      expect(user.reload.email).to eq("user@example.com")
    end
  end

  describe "destroy" do
    it "deletes a record" do
      expect{
        delete :destroy, type: "user", id: user.id
      }.to change(User, :count).by(-1)
      expect(response).to redirect_to documents_path("user")
    end
  end

end
