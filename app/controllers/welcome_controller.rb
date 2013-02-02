class WelcomeController < ApplicationController
  def index
    @posts = Recipe.published.page(params[:page])
    render template: 'posts/index'
  end
end
