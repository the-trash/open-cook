class User < ActiveRecord::Base
  authenticates_with_sorcery!

  # Relations
  has_many :hubs
  has_many :pages
  has_many :posts
  has_many :blogs
  has_many :recipes
  has_many :articles

  # validations
  validates :login,    presence: true, uniqueness: true
  validates :username, presence: true
  validates :password, presence: true, on: :create
end
