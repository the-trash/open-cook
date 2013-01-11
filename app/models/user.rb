class User < ActiveRecord::Base
  # attr_protected  :admin
  # attr_accessible :name

  authenticates_with_sorcery!

  # Relations
  has_many :posts
  has_many :menus
  has_many :recipes
  has_many :articles

  # validations
  validates :login,    presence: true, uniqueness: true
  validates :username, presence: true
  validates :password, presence: true, on: :create
end
