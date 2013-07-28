class UsersController < ApplicationController
  before_action :user_require,  only: [:cabinet]
  before_action :role_required, only: [:cabinet]

  def index
    @users = User.includes(:role).order("role_id ASC").page(params[:page])
  end

  def show
    @user = User.where(login: params[:id]).first
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new params.require(:user).permit(:login, :email, :password)
    if @user.save
      login(@user.login, @user.open_password, false)
      redirect_to root_url, :notice => t('.created')
    else
      render :new
    end
  end

  # secured
  def cabinet; end
end
