require 'spec_helper'

FactoryGirl.define do
  factory :admin_user, class: User do
    login :admin
    email "admin@site.com"
    password 'qwerty'
  end

  factory :user, class: User do
    sequence(:email){ Faker::Internet.email }
    sequence(:login){ Faker::Internet.user_name }
    password 'qwerty'
  end
end