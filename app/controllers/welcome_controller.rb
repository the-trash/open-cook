class WelcomeController < ApplicationController
  def index
    per_count = 7
    @hubs  = Hub.of_(:posts).with_states(:published)
    @posts = Post.published_rset.pagination(params)
  end
end
