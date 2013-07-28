class ApplicationController < ActionController::Base
  include RedirectBack
  include SorceryAddons
  include TheRoleAddons
  include TheRoleController
  include TheCommentsController::ViewToken

  layout('open_cook/application')

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  alias_method :user_require,       :require_login
  alias_method :role_access_denied, :access_denied

  before_action :define_user
  after_action  :save_audit

  private

  # to show @root | @user elements
  def define_user
    @user = User.root

    if params[:user_id]
      @user = if TheFriendlyId.int? params[:user_id]
        User.where(params[:user_id]).first
      else
        User.where(login: params[:user_id]).first
      end
    end
  end

  def save_audit
    (@audit || Audit.new.init(self)).save
  end

  def access_denied
    redirect_to redirect_back_or(login_url), alert: "You have not role"
  end

  def not_authenticated
    redirect_to login_url, alert: "First log in to view this page"
  end
end