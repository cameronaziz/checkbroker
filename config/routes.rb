Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'static_pages#index'

  resources :portfolios
  resources :users
  resources :groups
  resources :mutual_funds

  #Login / Logout
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'sign-up' => 'users#register', as: :register
  post 'sign-up' => 'users#create_register'

  #Brokerage Registration
  get 'brokerage/signup' => 'users#brokerage_registration', as: :brokerages_signup
  post 'brokerage/signup' => 'users#brokerage_registration_create'

  #User Registration

  #Useless Pages
  get 'profile' => 'static_pages#profile'
  get 'legal' => 'static_pages#legal'
  get 'privacy' => 'static_pages#privacy'
  get 'help' => 'static_pages#help'

  #Future Needed
  get 'reviews' => 'reviews#index'

  resources :advisors

  #View Brokerages
  get 'brokerages/:id/raw' => 'brokerages#raw', as: :brokerage_raw
  get 'brokerages/:id/verify' => 'brokerages#brokerage_verify', as: :brokerage_verify
  get 'mutual_fund_update/:ticker' => 'mutual_funds#update_mutual_fund', as: :update_mutual_fund
  resources :brokerages


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

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
