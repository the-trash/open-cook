require 'spec_helper'

describe "Welcome" do

  it "root" do
    role = FactoryGirl.create(:role)
    user = FactoryGirl.build(:ivan)
    user.role = role
    user.save

    visit('/')
  end
end
