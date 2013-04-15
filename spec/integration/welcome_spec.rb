require 'spec_helper'

describe "Welcome" do

  it "root" do
    role = FactoryGirl.create(:role)
    user = User.new({
      :login => "Ivan",
      :email => "ivan@ivan,com",
      :password => "qwerty",
      :role => role
    })

    p user
    user.save!

    # visit('/')
  end
end
