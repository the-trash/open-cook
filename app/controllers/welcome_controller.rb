class WelcomeController < ApplicationController
  def index
    @posts = Recipe.includes(:user).published.page(params[:page])
    render template: 'posts/index'
  end
end
