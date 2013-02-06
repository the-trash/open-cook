class User < ActiveRecord::Base
  authenticates_with_sorcery!

  include DefaultRole
  include DefineOpenPassword

  before_validation :prepare_login, on: :create

  def to_param; self.login end

  # Relations
  has_many :hubs
  has_many :pages
  has_many :posts
  has_many :blogs
  has_many :notes
  has_many :recipes
  has_many :articles

  # validations
  validates :login,    presence: true, uniqueness: true
  validates :email,    presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  # replace in TheRole
  def self.with_role name
    Role.where(name: name).first.users
  end

  private

  def prepare_login
    self.login = Russian::translit(self.login).parameterize
  end
end
