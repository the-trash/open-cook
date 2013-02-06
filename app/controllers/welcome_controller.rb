class WelcomeController < ApplicationController
  def index
    @posts = Recipe.includes(:user).with_states(:published).page(params[:page])
    render template: 'posts/index'
  end
end
