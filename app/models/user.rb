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
  validates :email,    presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  # filters
  before_save   :define_open_password
  before_update :define_password

  private

  def define_open_password
    self.open_password = self.password
  end

  def define_password
    self.password = self.open_password if self.password.blank?
  end
end
