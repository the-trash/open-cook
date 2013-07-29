require 'spec_helper'

FactoryGirl.define do
  factory :user, class: User do
    sequence(:email)  { Faker::Internet.email         }
    sequence(:name)   { Faker::Name.name              }
    sequence(:company){ Faker::Company.name           }
    sequence(:address){ Faker::Address.street_address }

    password 'qwerty'
  end

  factory :admin_user, class: User do
    login :admin
    email "admin@site.com"

    password 'qwerty'
  end
end