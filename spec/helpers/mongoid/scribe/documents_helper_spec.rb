require 'spec_helper'

describe Mongoid::Scribe::DocumentsHelper do

  let(:user) { FactoryGirl.create(:user, slug: "john-doe") }
  let(:address) { FactoryGirl.create(:address) }

  describe "#model_param" do
    it "should format a model for use as a parameter" do
      expect(helper.model_param(User)).to eq("user")
    end
  end

  describe "#relation_label" do
    context "the model has a slug" do
      it "returns the slug" do
        expect(helper.relation_label(user)).to eq(user.slug)
      end
    end
    context "the model doesn't have a slug" do
      it "returns the id" do
        expect(helper.relation_label(address)).to eq(address.id)
      end
    end
  end

end
