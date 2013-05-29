class WelcomeController < ApplicationController
  def index
    per_count = 7

    @hubs   = Hub.of_(:posts).with_states(:published)
    @posts  = Post.active_publications.page(params[:page]).per(per_count).to_a
    @posts.sort{ |x,y| y.created_at <=> x.created_at }
  end
end
