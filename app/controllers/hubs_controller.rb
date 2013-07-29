class HubsController < ApplicationController
  include TheSortableTreeController::Rebuild
  include TheSortableTreeController::ExpandNode
  
  before_action :set_hub_and_user, only: %w[show edit update destroy]

  # PROTECTED
  def manage
    @hubs = @user.hubs.for_manage_rset.pagination(params)
  end

  def new
    @hub = Hub.new
  end

  def edit; end

  def update
    if @hub.update(hub_params)
      redirect_to url_for([:edit, @hub.user, @hub]),
                  notice: "Hub was successfully updated."
    else
      @hub.update_attachment_fields(:main_image)
    end
  end  

  def create
    @hub = current_user.hubs.new(hub_params)

    if @hub.save
      redirect_to url_for([:edit, @hub.user, @hub]),
                  notice: "Hub was successfully created."
    else
      render template: :new
    end
  end
  
  def selector
    @hub = Hub.find(params[:hub_id])
    render layout: false, template: 'hubs/_selector'
  end

  private

  def set_hub_and_user
    @hub  = Hub.for_manage.friendly_first(params[:id])
    @user = @hub.user
  end

  def hub_params
    # TODO: user_id for create
    # TODO: user_id for update only for moderator|admin
    params.require(:hub).permit(
      :user_id,
      :hub_id,
      :slug,
      :main_image,
      :pubs_type,
      :author, :keywords, :description, :copyright,
      :title,
      :raw_intro,
      :raw_content,
      :state
    )
  end

  # include PublicationController

  # def show
  #   @hub = @hub
  #   @hub.increment!(:show_count)
    
  #   @hubs = @hub.siblings.published_set
  #   @hubs = @hub.hubs.published_set.pagination(params)

  #   render 'hubs/index'
  # end

  # def manage
  #   @hubs = @user.send(controller_name)
  #             .roots
  #             .nested_set
  #             .with_states(:draft, :published)
  #             .pagination(params)
  # end

  # def system_section
  #   @hub   = Hub.friendly_first(params[:type])
  #   @hubs  = @hub.descendants
  #   @hubs = hub
  #             .nested_set
  #             .with_states(:draft, :published)
  #             .where(hub_id: @hubs.ids.push(@hub.id))
  #             .pagination(params)

  #   render 'hubs/index'
  # end
end