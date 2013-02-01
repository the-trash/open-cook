class WelcomeController < ApplicationController
  def index
    @posts = Recipe.published.page(params[:page])
    render 'posts/index'
  end
end
