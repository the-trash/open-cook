class MenusController < ApplicationController
  include BasePostController
  skip_before_action :set_klass, :set_post

  def show
    @menu  = Hub.friendly_where(params[:id]).published.first
    @user  = @menu.user
    @posts = @menu.recipes.published.page(params[:page])
    render 'posts/index'
  end

end