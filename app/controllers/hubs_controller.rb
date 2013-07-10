class HubsController < ApplicationController
  include PublicationController
  include TheSortableTreeController::Rebuild
  include TheSortableTreeController::ExpandNode

  def show
    @hub = @post
    @hub.increment!(:show_count)
    
    @hubs = @hub.siblings.published_set
    @posts = @hub.posts.published_set.pagination(params)

    render 'posts/index'
  end

  def set_post_and_user
    @post = Hub.friendly_where(params[:id]).with_states(:published, :draft).first
    @user = @post.user
  end

  def selector
    @hub = Hub.find(params[:hub_id])
    render layout: false, template: 'hubs/_selector'
  end

  def manage
    @posts = @user.send(controller_name)
              .roots
              .nested_set
              .with_pub_type(params[:pub_type])
              .with_states(:draft, :published)
              .pagination(params)
  end

  def system_section
    @hub   = Hub.friendly_first(params[:type])
    @hubs  = @hub.descendants
    @posts = Post
              .nested_set
              .with_states(:draft, :published)
              .where(hub_id: @hubs.ids.push(@hub.id))
              .pagination(params)

    render 'posts/index'
  end
end