class HubsController < ApplicationController
  include PublicationController
  include TheSortableTreeController::Rebuild
  include TheSortableTreeController::ExpandNode

  def show
    @hub = @post
    @hub.increment!(:show_count)
    
    @hubs = @hub.same_hubs
              .nested_set
              .with_state(:published)

    @posts = @hub.posts
              .nested_set
              .with_state(:published)
              .page(params[:page]).per(params[:per_page])

    render 'posts/index'
  end

  def set_post_and_user
    @post = Hub.friendly_where(params[:id]).with_states(:published, :draft).first
    @user = @post.user
  end

  def selector
    initialize_hubs_selector(params[:id], params[:klass], params[:pub_type])
    render layout: false, template: 'hubs/_selector'
  end

  def manage
    @posts = @user.send(controller_name)
              .roots
              .nested_set
              .with_pub_type(params[:pub_type])
              .with_states(:draft, :published)
              .page(params[:page]).per(params[:per_page])
  end

  def system_section
    @hub   = Hub.with_title(params[:type])
    @hubs  = @hub.descendants
    @posts = Post
              .nested_set
              .with_states(:draft, :published)
              .where(hub_id: @hubs.ids.push(@hub.id))
              .page(params[:page]).per(params[:per_page])

    render 'posts/index'
  end
end