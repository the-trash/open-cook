require 'spec_helper'

FactoryGirl.define do
  factory :ivan, class: User do
    login "Ivan"
    email "ivan@ivan,com"
    password "qwerty"
  end
end