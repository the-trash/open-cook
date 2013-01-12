class Hub < ActiveRecord::Base
  belongs_to :user

  has_many :posts
  has_many :blogs
  has_many :recipes
  has_many :articles

  validates_presence_of  :user_id, :title, :hub_type
end
