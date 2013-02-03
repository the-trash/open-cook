class UsersController < ApplicationController
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
    @user = User.new(params[:user])
    if @new_user.save
      login(@user.login, @user.open_password, false)
      redirect_to root_url, :notice => t('.created')
    else
      render :new
    end
  end

  # secured
  def cabinet; end

end
