require 'spec_helper'

FactoryGirl.define do
  factory :post, class: Post do
    sequence(:title) { Faker::Lorem.sentence }
  end
end