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

  def admin?
    self == User.first
  end

  # TheComments
  include TheCommentModels::User

  def comment_moderator? comment
    admin? || id == comment.holder_id
  end

  def commentable_title
    login
  end

  def commentable_path
    [self.class.to_s.tableize, login].join('/')
  end
  

  # replace in TheRole
  def self.with_role name
    Role.where(name: name).first.users
  end

  private

  def prepare_login
    self.login = Russian::translit(self.login).parameterize
  end
end
