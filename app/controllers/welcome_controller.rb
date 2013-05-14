class WelcomeController < ApplicationController
  def index
    per_count = 7

    @hubs   = Hub.of_(:recipes).with_states(:published)
    @posts  = Recipe.active_publications.page(params[:page]).per(per_count).to_a
    @posts |= Post.active_publications.page(params[:page]).per(per_count).to_a
    @posts |= Blog.active_publications.page(params[:page]).per(per_count).to_a
    @posts.sort{ |x,y| y.created_at <=> x.created_at }
  end
end
