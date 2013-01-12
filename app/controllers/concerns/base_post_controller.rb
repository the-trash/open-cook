module BasePostController
  extend ActiveSupport::Concern

  included do
    before_action :set_klass
    before_action :set_post,  only: [:show, :edit, :update, :destroy]

    def index
      @posts = @klass.fresh.published
    end

    def show; end
    def edit; end

    def new
      @post = @klass.new
    end

    def create
      @post = @klass.new(post_params)

      if @post.save
        redirect_to @post, notice: "#{@klass.to_s} was successfully created."
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /posts/1
    def update
      if @post.update(post_params)
        redirect_to @post, notice: "#{@klass.to_s} was successfully updated."
      else
        render action: 'edit'
      end
    end

    def destroy
      @post.destroy
      redirect_back_or posts_url
    end

    private

    def set_klass
      @klass = controller_name.classify.constantize
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = @klass.find params[:id]
    end
  end

  # module InstanceMethods; end
  # module ClassMethods; end
end