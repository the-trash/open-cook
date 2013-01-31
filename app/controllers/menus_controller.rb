class MenusController < ApplicationController
  include BasePostController

  skip_before_action :set_klass, :set_post

  def show
    @menu  = Hub.find(params[:id])
    @recipes = @menu.recipes
    render 'menus/show'
  end

end