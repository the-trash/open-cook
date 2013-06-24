module PublicationController
  include HubCells
  extend ActiveSupport::Concern

  included do
    before_action :set_klass
    before_action :set_post_and_user,   only: [:show, :edit, :update, :destroy]
    before_action :protect_post_action, only: [:show, :edit, :update, :destroy]

    # after_action -> { @audit = Audit.new.init(self, @post) }, only: [:create, :show, :update, :edit, :destroy]

    include TheSortableTreeController::ReversedRebuild

    def index
      # TODO: posts from hidden hubs should not be visible
      user   = User.where(login: user_id).first || @root
      @posts = user.send(controller_name)
                .reversed_nested_set
                .with_states(:published)
                .page(params[:page]).per(params[:per_page])
      render 'posts/index'
    end

    def show
      @post.increment!(:show_count)
      @hubs     = @post.hub.same_hubs.with_state(:published).nested_set
      @comments = @post.comments.with_state(:draft, :published).nested_set
      render 'posts/show'
    end

    # PROTECTED
    def manage
      @posts = @user.send(controller_name)
                .reversed_nested_set
                .with_pub_type(params[:pub_type])
                .with_states(:draft, :published)
                .page(params[:page]).per(params[:per_page])
      render 'posts/manage'
    end

    def edit
      initialize_hubs_selector(@post.id, @post.class.to_s, @post.pub_type)
      render 'posts/edit'
    end

    def new
      initialize_hubs_selector
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
        render 'posts/edit'
      end
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
      # return render text: params
      @post = @klass.friendly_where(params[:id]).with_states(:published, :draft).first
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