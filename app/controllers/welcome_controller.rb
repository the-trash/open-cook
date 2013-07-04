class WelcomeController < ApplicationController
  def index
    per_count = 7

    @hubs   = Hub.of_(:posts).with_states(:published)
    @posts  = Post
              .active_pubs
              .page(params[:page]).per(params[:per_page])

  end
end
