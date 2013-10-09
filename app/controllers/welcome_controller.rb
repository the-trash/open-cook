class WelcomeController < ApplicationController
  def index
    per_count = 7
    @hubs  = Hub.of_(:posts).with_states(:published)
    @posts = Post.published_rset.pagination(params)
  end

  # Legacy urls
  def legacy_post
    if post = Post.where(legacy_url: params[:id]).first
      redirect_to post_url(post.friendly_id), status: :moved_permanently
    end
  end
end
