module BasePostController
  extend ActiveSupport::Concern

  included do
    before_action :set_klass
    before_action :set_post,  only: [:show, :edit, :update, :destroy]

    def index
      user   = User.where(login: params[:user]).first || @root
      @posts = user.send(controller_name).fresh.published
      render 'posts/index'
    end

    def show
      render 'posts/show'
    end

    def edit
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
    def set_post
      @post = @klass.find params[:id]
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