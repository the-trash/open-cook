require 'spec_helper'

FactoryGirl.define do
  factory :role do
    name "bla"
    title "bla"
    description "bla"
    the_role "{}"
  end

  factory :ivan, class: User do
    login "Ivan"
    email "ivan@ivan,com"
    password "qwerty"
  end
end