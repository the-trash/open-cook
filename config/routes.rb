TheApp::Application.routes.draw do
  root to: 'welcome#index'

  resources :audits

  # Legacy Urls
  # /recipes/rc56797---lavandovyy-limonad
  # /recipes/tags/milk
  get "recipes/:id" => "welcome#legacy_post"
  get "recipes/tag/:id", to: redirect { |params, request| URI.encode "#{request.protocol + request.host_with_port}/tag/#{params[:id]}" }

  # Login system
  get    "login"    => "sessions#new",     as: :login
  delete "logout"   => "sessions#destroy", as: :logout
  get    "signup"   => "users#new",        as: :signup
  post   "sessions" => "sessions#create",  as: :sessions

  # Personal
  get "cabinet" => "users#cabinet", as: :cabinet

  concern   :user_comments,  TheComments::UserRoutes.new
  concern   :admin_comments, TheComments::AdminRoutes.new
  resources :comments, concerns:  [:user_comments, :admin_comments]

  concern :sortable_tree do
    collection do
      get  :manage
      post :rebuild
    end
  end

  # Direct routes
  %w{ hubs pages posts }.each do |name|
    resources name, concerns: :sortable_tree
  end

  resources :hubs do
    post :expand_node, on: :collection
    # post :selector,    on: :collection
  end

  # Users
  resources :users, only: [:index, :show, :create] do
    %w{ hubs pages posts }.each do |name|
      resources name, concerns: :sortable_tree
    end
  end

  # tags
  get "tag/:tag" => "posts#tag", as: :tag

  # /users/:user_id/manage/recipes
  get "manage/:pub_type" => 'posts#manage', as: :pubs_manage
  get "users/:user_id/manage/:pub_type" => 'posts#manage', as: :user_pubs_manage

  # TheStorages
  patch '/image_processor/rotate_left/:id',  as: :rotate_left,  to: 'image_processor#rotate_left'
  patch '/image_processor/rotate_right/:id', as: :rotate_right, to: 'image_processor#rotate_right'
  patch '/image_processor/crop_image',       as: :crop_image,   to: 'image_processor#crop_image'

  get "/:id" => 'hubs#system_section', as: :system_hub

  # Main image
  delete 'delete_main_image/:storage_type/:storage_id'   => "attached_files#delete_main_image",      as: :delete_main_image
  patch  'main_image_to_left/:storage_type/:storage_id'  => "attached_files#main_image_to_left",     as: :main_image_to_left
  patch  'main_image_to_right/:storage_type/:storage_id' => "attached_files#main_image_to_right",    as: :main_image_to_right
  post   'crop_image_for_preview'                        => "attached_files#crop_image_for_preview", as: :crop_image_for_preview
end