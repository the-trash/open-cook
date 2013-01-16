class UsersController < ApplicationController
  def new
    @new_user = User.new
  end

  def create
    @new_user = User.new(params[:user])
    if @new_user.save
      login(@new_user.login, @new_user.open_password, false)
      redirect_to root_url, :notice => t('.created')
    else
      render :new
    end
  end

  def index
    @users = User.all
  end

  def cabinet; end
end
