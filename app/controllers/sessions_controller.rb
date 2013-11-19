class SessionsController < ApplicationController
  def new; end

  def create
    user = login(params[:login], params[:password], params[:remember_me])
    if user
      flash[:notice] = t('sessions.create.notice')
      redirect_to cabinet_url
    else
      flash.now.alert = t('sessions.create.alert')
      render :new
    end
  end

  def destroy
    logout 
    redirect_back notice: t('sessions.destroy.notice')
  end
end
