TheApp::Application.routes.draw do
  root to: 'welcome#index'

  patch '/image_processor/rotate_left/:id',  as: :rotate_left,  to: 'image_processor#rotate_left'
  patch '/image_processor/rotate_right/:id', as: :rotate_right, to: 'image_processor#rotate_right'

  # login system
  get    "login"    => "sessions#new",     as: :login
  delete "logout"   => "sessions#destroy", as: :logout
  post   "sessions" => "sessions#create",  as: :sessions

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

  # direct routes
  %w{ hubs pages posts blogs notes recipes articles }.each do |name|
    resources name, concerns: :sortable_tree
  end

  # users
  resources :users, only: [:index, :show, :create] do
    %w{ pages posts blogs notes recipes articles hubs }.each do |name|
      resources name, concerns: :manage
    end
  end

  get  "signup"  => "users#new",     as: :signup
  get  "cabinet" => "users#cabinet", as: :cabinet

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
