TheApp::Application.routes.draw do
  root to: 'welcome#index'

  # Login system
  get    "login"    => "sessions#new",     as: :login
  delete "logout"   => "sessions#destroy", as: :logout
  get    "signup"   => "users#new",        as: :signup
  post   "sessions" => "sessions#create",  as: :sessions

  # Personal
  get "cabinet" => "users#cabinet", as: :cabinet

  # Concerns
  concern :manage do
    collection do
      get :manage
    end
  end

  concern :sortable_tree do
    collection do
      get  :manage
      post :rebuild
    end
  end

  # Direct routes
  %w{ hubs pages posts blogs notes recipes articles }.each do |name|
    resources name, concerns: :sortable_tree
  end

  # Users
  resources :users, only: [:index, :show, :create] do
    %w{ pages posts blogs notes recipes articles hubs }.each do |name|
      resources name, concerns: :manage
    end
  end

  # TheStorages
  patch '/image_processor/rotate_left/:id',  as: :rotate_left,  to: 'image_processor#rotate_left'
  patch '/image_processor/rotate_right/:id', as: :rotate_right, to: 'image_processor#rotate_right'
  patch '/image_processor/crop_image',       as: :crop_image,   to: 'image_processor#crop_image'

end