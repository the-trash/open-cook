require 'spec_helper'

describe "User" do
  context "Available Hubs" do
    context "Admin" do
      before(:each) do
        UsersMacros.create_admin
        HubsMacros.create_basic_hubs
      end

      it "Check for test data" do
        User.first.admin?.should be_true
        Hub.count.should eq 3
      end

      it "Check for Available Hubs" do
        User.first.available_hubs.count.should eq 3
      end
    end

    context "Blogger User" do
      before(:each) do
        UsersMacros.create_admin
        UsersMacros.create_blogger
        HubsMacros.create_basic_hubs
      end

      it "Check for Available Hubs" do
        User.last.available_hubs.count.should eq 1
      end

      it "Check for Available Hubs with scope" do
        Hub.friendly_first(:blogs)
        User.last.available_hubs(:pages).count.should eq 0
      end

      it "Only published Hubs are available" do
        Hub.friendly_first(:blogs).to_draft
        User.last.available_hubs.count.should eq 0
      end
    end
  end
end