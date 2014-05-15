require 'spec_helper'

describe Mongoid::Scribe::DocumentsController do

  routes { Mongoid::Scribe::Engine.routes }

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
    end
  end

  describe "show" do
    it "does something" do
    end
  end

  describe "edit" do
    it "does something" do
    end
  end

  describe "update" do
    it "does something" do
    end
  end

  describe "create" do
    it "does something" do

    end
  end

  describe "destroy" do
    it "does something" do
    end
  end

end
