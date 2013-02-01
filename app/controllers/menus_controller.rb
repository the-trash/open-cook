class MenusController < ApplicationController
  include BasePostController

  skip_before_action :set_klass, :set_post

  def show
    @menu  = Hub.friendly_where(params[:id]).published.first
    @recipes = @menu.recipes
    render 'menus/show'
  end

end