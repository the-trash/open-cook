class ApplicationController < ActionController::Base
  include RedirectBack
  include SorceryAddons

  layout 'bootstrap_fixed'

  # @user - to show
  # @root - root user
  # current_user - logined user
  before_action :define_root
  before_action :define_user

  # role
  def access_denied
    render :text => 'access_denied: requires an role' and return
  end

  alias_method :login_required,     :require_login
  alias_method :role_access_denied, :access_denied
  #~ role

  after_action -> { (@audit || Audit.new.init(self)).save }

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

end