require 'spec_helper'

describe Mongoid::Scribe do

  describe "the authenticate_with setting" do
    after { Mongoid::Scribe.configure { authenticate_with Mongoid::Scribe::DEFAULT_AUTHENTICATION_FILTER } }
    it "should have a default filter that returns true" do
      expect(Mongoid::Scribe.authentication_filter).to be_nil
    end
    it "should be configurable" do
      Mongoid::Scribe.configure { authenticate_with :require_admin_user }

      expect(Mongoid::Scribe.authentication_filter).to eq(:require_admin_user)
    end
  end

  describe "the mount_at setting" do
    after { Mongoid::Scribe.configure { mount_at Mongoid::Scribe::DEFAULT_ENDPOINT } }
    it "should have a default of /documents" do
      expect(Mongoid::Scribe.endpoint).to eq("/documents")
    end
    it "should be configurable" do
      Mongoid::Scribe.configure { mount_at "/admin/documents" }

      expect(Mongoid::Scribe.endpoint).to eq("/admin/documents")
    end
  end

end
