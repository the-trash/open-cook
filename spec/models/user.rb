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
        User.last.available_hubs.count.should eq 2
      end
    end
  end
end