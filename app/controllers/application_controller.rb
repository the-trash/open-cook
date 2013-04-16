class ApplicationController < ActionController::Base
  include RedirectBack
  include SorceryAddons
  include TheRoleAddons
  include TheRoleController

  include TheCommentsController::ViewToken

  layout 'bootstrap_fixed'

  # @user - to show
  # @root - root user
  # current_user - logined user
  before_action :define_root
  before_action :define_user
  after_action  :save_audit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def define_root
    @root = User.with_role(:admin).first
  end

  def define_user
    @user = @root
    if params[:user_id]
      @user = if params[:user_id].to_i.to_s == params[:user_id]
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