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

  def selector
    root_hub = Hub.with_title(params[:pub_type])
    return render nothing: true unless root_hub

    @hubs = root_hub.children
    return render nothing: true if @hubs.blank?

    @selected_hub = params[:klass].constantize.find(params[:id]).try(:hub)
    render layout: false
  end
end