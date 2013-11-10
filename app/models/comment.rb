class Comment < ActiveRecord::Base
  include TheComments::Comment
  include CommonClassMethods
end
