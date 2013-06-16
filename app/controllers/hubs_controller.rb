class HubsController < ApplicationController
  include PublicationController

  def show
    @hub = @post
    @hub.increment!(:show_count)
    @hubs = @hub.same_hubs.with_state(:published).nested_set

    @posts = @hub.publications.with_state(:published).nested_set.page(params[:page])
    render 'posts/index'
  end

  def set_post_and_user
    @post = Hub.where(title: params[:id]).with_states(:published, :draft).first
    @user = @post.user
  end
end