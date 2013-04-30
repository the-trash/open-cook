class HubsController < ApplicationController
  include PublicationController

  def show
    @hub = @post
    @hub.increment!(:show_count)
    @hubs = @hub.same_hubs.with_state(:published).nested_set

    @posts = @hub.publications.with_state(:published).nested_set.page(params[:page])
    render 'posts/index'
  end
end