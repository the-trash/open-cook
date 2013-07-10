class User < ActiveRecord::Base
  authenticates_with_sorcery!
  include DefineOpenPassword

  include TheRoleUserModel
  
  include ActAsStorage
  include HasAttachedFiles

  include TheCommentsUser
  include TheCommentsCommentable

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
  before_validation :prepare_login, on: :create

  validates :login,    presence: true, uniqueness: true
  validates :email,    presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  def self.root
    @@root ||= User.first
  end

  def admin?
    self == User.root
  end

  # TheComments methods
  def comment_moderator? comment
    admin? || id == comment.holder_id
  end

  def commentable_title
    login
  end

  def commentable_path
    [self.class.to_s.tableize, login].join('/')
  end

  private

  def prepare_login
    self.login = self.login.to_s.to_slug_param
  end
end
