class User < ActiveRecord::Base
  authenticates_with_sorcery!

  include DefaultRole
  include DefineOpenPassword

  def to_param; self.login end

  # Relations
  has_many :hubs
  has_many :pages
  has_many :posts
  has_many :blogs
  has_many :recipes
  has_many :articles

  # validations
  validates :login,    presence: true, uniqueness: true
  validates :email,    presence: true, uniqueness: true
  validates :password, presence: true, on: :create
end
