require 'spec_helper'

FactoryGirl.define do
  factory :role, class: Role do
    name "admin"
    title "bla"
    description "bla"
    the_role "{}"
  end
end