TheApp::Application.routes.draw do
  root to: 'welcome#index'

  # login system
  get    "login"    => "sessions#new",     as: :login
  delete "logout"   => "sessions#destroy", as: :logout
  post   "sessions" => "sessions#create",  as: :sessions

  # users
  resources :users, only: [:index, :show, :create]
  get  "signup"  => "users#new",     as: :signup
  get  "cabinet" => "users#cabinet", as: :cabinet

  concern :sortable_tree do
    collection do
      get  :manage
      post :rebuild
    end
  end

  # post set
  resources :hubs,     concerns: :sortable_tree
  resources :pages,    concerns: :sortable_tree
  resources :posts,    concerns: :sortable_tree
  resources :blogs,    concerns: :sortable_tree
  resources :recipes,  concerns: :sortable_tree
  resources :articles, concerns: :sortable_tree

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
