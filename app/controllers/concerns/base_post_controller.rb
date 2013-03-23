module BasePostController
  extend ActiveSupport::Concern

  included do
    before_action :set_klass
    before_action :set_post_and_user,   only: [:show, :edit, :update, :destroy]
    before_action :protect_post_action, only: [:show, :edit, :update, :destroy]

    after_action -> { @audit = Audit.new.init(self, @post) }, only: [:create, :show, :update, :edit, :destroy]

    include TheSortableTreeController::Rebuild

    def index
      user   = User.where(login: params[:user]).first || @root
      @posts = user.send(controller_name).nested_set.with_states(:published).page(params[:page])
      render 'posts/index'
    end

    def show
      @comments = @post.comments.with_state(:draft, :published).nested_set
      @post.increment!(:show_count)
      render 'posts/show'
    end

    # PROTECTED
    def manage
      @posts = @user.send(controller_name).with_states(:draft, :published).nested_set.page(params[:page])
    end

    def edit
      @post = @post.first
      render 'posts/edit'
    end

    def new
      @post = @klass.new
      render 'posts/new'
    end

    def create
      @post = @klass.new(post_params)

      if @post.save
        redirect_to @post, notice: "#{@klass.to_s} was successfully created."
      else
        # render action: 'new'
        render 'posts/new'
      end
    end

    # PATCH/PUT /posts/1
    def update
      if @post.update(post_params)
        redirect_to @post, notice: "#{@klass.to_s} was successfully updated."
      else
        # render action: 'edit'
        render 'posts/edit'
      end
    end

    def destroy
      @post.destroy
      redirect_back_or posts_url
    end

    private

    def set_klass
      @klass     = controller_name.classify.constantize
      @klass_sym = controller_name.singularize.to_sym
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post_and_user
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


    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(@klass_sym).permit(
        :user_id,
        :author, :keywords, :description, :copyright,
        :title,
        :raw_intro,
        :raw_content,
        :main_image_url,
        :state,
        :first_published_at)
    end
  end

  # module InstanceMethods; end
  # module ClassMethods; end
end