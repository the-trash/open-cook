module PublicationController
  include HubCells
  extend ActiveSupport::Concern

  included do
    before_action :set_klass
    before_action :set_post_and_user,   only: %w[show edit update destroy]
    before_action :protect_post_action, only: %w[show edit update destroy]
    before_action :set_audit,           only: %w[create show update edit destroy]

    include TheSortableTreeController::ReversedRebuild

    def index
      # TODO: posts from hidden hubs should not be visible
      user   = User.where(login: user_id).first || @root
      @posts = user.send(controller_name).for_manage_rset.pagination(params)

      render 'posts/index'
    end

    def show
      @hub      = @post.hub
      @hubs     = @hub.siblings.published_set
      @comments = @post.comments.for_manage_set
      @post.increment!(:show_count) if @post.published?

      render 'posts/show'
    end

    # PROTECTED
    def manage
      @posts = @user.send(controller_name).for_manage_rset.pagination(params)

      render 'posts/manage'
    end

    def edit
      render 'posts/edit'
    end

    def new
      @post = @klass.new
      render 'posts/new'
    end

    def create
      @post = current_user.send(controller_name).new(post_params)

      if @post.save
        redirect_to url_for([:edit, @post.user, @post]),
                    notice: "#{@klass.to_s} was successfully created."
      else
        render 'posts/new'
      end
    end

    # PATCH/PUT /posts/1
    def update
      if @post.update(post_params)
        redirect_to url_for([:edit, @post.user, @post]),
                    notice: "#{@klass.to_s} was successfully updated."
      else
        @post.update_attachment_fields(:main_image)
        render 'posts/edit'
      end
    end

    def set_audit
      @audit = Audit.new.init(self, @post)
    end

    def destroy
      @post.destroy
      redirect_back_or posts_url
    end

    private

    def set_klass
      @klass      = controller_name.classify.constantize
      @klass_name = controller_name.singularize.to_sym
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post_and_user
      @post = @klass.for_manage.with_users.friendly_first(params[:id])
      @user = @post.user
    end

    def protect_post_action
      true
      # TODO; THE ROLE!
      # return true if current_user.owner? @post
      # return true if controller_action.to_sym == :show and @post.published?
      # return render text: 'secured area'
    end

    def user_id
      params[:user] || params[:user_id]
    end

    def post_params
      # TODO: user_id for create
      # TODO: user_id for update only for moderator|admin
      params.require(@klass_name).permit(
        :user_id,
        :hub_id,
        :slug,
        :main_image,
        :pub_type,
        :author, :keywords, :description, :copyright,
        :title,
        :raw_intro,
        :raw_content,
        :state
      )
    end
  end
end