class Page < ActiveRecord::Base
  include BasePublication
  # has_many :spam_comments, conditions: { spam: true }, class_name: 'Comment'
  # has_many :spam_comments, -> { where spam: true }, class_name: 'Comment'
end