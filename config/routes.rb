Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'static_pages#index'

  get 'suggestion' => 'static_pages#help'
  get 'help' => 'static_pages#help'

  get 'calendar' => 'calendars#ical'
  get 'hot_shots' => 'hot_shots#index'
  post 'hot_shots/results'
  get 'hot_shots/results'

  resources :customers do
    resources :customer_addresses
  end

  resources :warehouses
  resources :shipping_companies
  resources :users
  resources :groups
  get 'tickets/calendar' => 'tickets#ics_export'
  resources :tickets
  post 'tickets' => 'tickets#index'
  patch 'tickets/:id/close' => 'tickets#close', as: 'close_ticket'
  post 'tickets/:id' => 'ticket_comments#create'

  resources :ticket_statuses, path: 'ticket_admin/statuses'
  resources :ticket_priorities, path: 'ticket_admin/priorities'
  resources :ticket_types, path: 'ticket_admin/types'
  resources :password_entries, path: 'passwords'

  get 'password_masters' => 'password_masters#pass'
  post 'password_masters' => 'password_masters#update_password'

  get 'mail' => 'emails#connect'



  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'


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
