require "spec_helper"

describe 'users/cabinet.html.haml' do
  describe :cabinet do

    context "Blogger goes to his cabinet" do
      before(:each) do
        TestCases.admin_blogger_hubs
        blogger = User.with_role(:blogger).first
        
        login_user(blogger)
        assign(:user, blogger)
      end

      # it "Blogger can see following links" do
      #   render
      #   rendered.should have_selector('a', count: 6)
      # end
    end

    context "Admin goes to bloggers cabinet" do
      before(:each) do
        TestCases.admin_blogger_hubs
        admin   = User.with_role(:admin).first
        blogger = User.with_role(:blogger).first

        login_user(admin)
        assign(:user, blogger)
      end

      # it "Admin can see following links" do
      #   render
      #   rendered.should have_selector('a', count: 9)
      # end
    end

  end
end