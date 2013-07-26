class ApplicationController < ActionController::Base
  include RedirectBack
  include SorceryAddons
  include TheRoleAddons
  include TheRoleController

  include TheCommentsController::ViewToken

  before_action :define_user
  after_action  :save_audit

  layout('open_cook/application')

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
end