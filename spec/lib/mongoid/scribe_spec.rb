require 'spec_helper'

describe Mongoid::Scribe do

  describe "the authenticate_with setting" do
    after { subject.configure { authenticate_with Mongoid::Scribe::DEFAULT_AUTHENTICATION_FILTER } }
    it "should have a default filter that returns true" do
      expect(subject.authentication_filter).to be_nil
    end
    it "should be configurable" do
      subject.configure { authenticate_with :require_admin_user }

      expect(subject.authentication_filter).to eq(:require_admin_user)
    end
  end

  describe "the mount_at setting" do
    after { subject.configure { mount_at Mongoid::Scribe::DEFAULT_ENDPOINT } }
    it "should have a default of /documents" do
      expect(subject.endpoint).to eq("/documents")
    end
    it "should be configurable" do
      subject.configure { mount_at "/admin/documents" }

      expect(subject.endpoint).to eq("/admin/documents")
    end
  end

  describe "the resources setting" do
    after { subject.configure { resources } }
    context "default" do
      it "should include all models" do
        expect(subject.models).to include(User)
        expect(subject.models).to include(Address)
      end
    end
    context "include option is used" do
      it "should include only the models specified" do
        subject.configure { resources include: [:user] }

        expect(subject.models).to include(User)
        expect(subject.models).to_not include(Address)
      end
    end
    context "exclude option is used" do
      it "should include all models except the ones specified" do
        subject.configure { resources exclude: [:user] }

        expect(subject.models).to_not include(User)
        expect(subject.models).to include(Address)
      end
    end
  end

  describe "form_configuration_for" do
    before do
      subject.configure do
        form_configuration_for User do
          field :first_name
          field :last_name
          field :email, type: :email
          field :slug
          field :admin, label: 'User is an admin'
          field :color, values: ['Red', 'Green', 'Blue', 'Purple', 'Orange']
          field :primary_address_id, values: ->(user) { user.addresses.all }
        end
      end
    end
    context "no options" do
      it "should include the column specified" do
        expect(subject.fields_for(User)).to be_an_instance_of(Hash)
        expect(subject.fields_for(User)[:first_name]).to eq({})
      end
    end
    context "label option is present" do
      it "should include the label option" do
        expect(subject.fields_for(User)[:admin]).to eq({label: 'User is an admin'})
      end
    end
    context "static values option is present" do
      it "should return the values specified" do
        expect(subject.fields_for(User)[:color]).to eq({values: ['Red', 'Green', 'Blue', 'Purple', 'Orange']})
      end
    end
    context "proc values option is present" do
      it "return the proc" do
        expect(subject.fields_for(User)[:primary_address_id][:values]).to be_an_instance_of(Proc)
      end
    end
    context "type option is present" do
      it "should return the type option" do
        expect(subject.fields_for(User)[:email]).to eq({type: :email})
      end
    end
  end

  describe "index_configuration_for" do
    before do
      subject.configure do
        index_configuration_for User do
          column :first_name
          column :full_name, value: ->(user) { user.first_name + " " + user.last_name}
        end
      end
    end
    context "no options" do
      it "should include the column specified" do
        expect(subject.index_for(User)).to be_an_instance_of(Hash)
        expect(subject.index_for(User)[:first_name][:value]).to be_nil
      end
    end
    context "value option is present" do
      it "should be a proc" do
        expect(subject.index_for(User)).to be_an_instance_of(Hash)
        expect(subject.index_for(User)[:full_name][:value]).to be_an_instance_of(Proc)
      end
    end
  end

end
