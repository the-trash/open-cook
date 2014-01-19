class Post < ActiveRecord::Base
  include BasePublication
  acts_as_taggable_on :names, :titles, :words
end