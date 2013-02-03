class ApplicationController < ActionController::Base
  include RedirectBack
  include SorceryAddons

  layout 'bootstrap_fixed'

  # @user - to show
  # @root - root user
  # current_user - logined user
  before_action :define_root
  before_action :define_user

  after_action  -> { (@audit || Audit.new.init(self)).save }

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def define_root
    @root = User.with_role(:admin).first
  end

  def define_user
    @user   = params[:user_id] == 0 ? User.where(params[:user_id]).first : User.where(login: params[:user_id]).first
    @user ||= @root
  end
end
