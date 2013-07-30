require 'spec_helper'

describe "App Base urls" do
  it_behaves_like "empty space"

  context "basic urls" do
    before(:each) do
      UsersMacros.create_admin
      HubsMacros.create_basic_hubs
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
