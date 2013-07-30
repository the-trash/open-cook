require 'spec_helper'

FactoryGirl.define do
  factory :role, class: Role do
    name "admin"
    title "bla"
    description "bla"
  end

  factory :admin_role, class: Role do
    name        :admin
    title       "Role for admin"
    description "This user can do anything"
  end

  factory :blogger_role, class: Role do
    name        :blogger
    title       "Role for Bloggers"
    description "User can work with his Blogs"
  end
end