class Post < ActiveRecord::Base
  include BasePublication
  validates_presence_of :pub_type
end