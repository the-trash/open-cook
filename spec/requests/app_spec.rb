require 'spec_helper'

describe "App Base urls" do
  it_behaves_like "empty space"

  context "basic urls" do
    before(:each) do
      UsersMacros.create_admin
      HubsMacros.create_basic_hubs
      PostsMacros.create_basic_articles
    end

    it "should be Hubs" do
      User.count.should eq 1
      Hub.count.should  eq 3
      Post.count.should eq 12
    end

    %w[ \  users login signup articles videos blogs].each do |path|
      it "/#{path}" do
        get "/#{path}"
        response.status.should be(200)
      end
    end
  end

  it_behaves_like "empty space"
end
