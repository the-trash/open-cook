class WelcomeController < ApplicationController
  def index
    @hubs  = Hub.of_(:posts).with_states(:published)
    @posts = Post.includes(:user).with_states(:published).page(params[:page])
    render template: 'posts/index'
  end
end
