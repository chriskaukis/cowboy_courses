Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  root 'home#index'

  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy', as: :logout
  delete 'logout' => 'sessions#destroy'
  get 'signup' => 'users#new', as: :signup
  post 'signup' => 'users#create'
  get 'contact' => 'home#contact', as: :contact
  post 'contact' => 'home#contact'

  get 'activate/:token' => 'users#activate', as: :activate

  resources :password_resets
  resources :subscriptions, :only => [:index]  
  resources :subjects
  
  resources :instructors do
    resources :comments, :except => [:index], :controller => 'instructors_comments'
    resources :votes, :only => [:up, :down]
    get 'up', :controller => 'instructors_votes', :action => 'up'
    get 'down', :controller => 'instructors_votes', :action => 'down'
  end
  
  resources :courses do
    resources :comments, :except => [:index], :controller => 'courses_comments'
    resources :votes, :only => [:up, :down]
    get 'up', :controller => 'courses_votes', :action => 'up'
    get 'down', :controller => 'courses_votes', :action => 'down'
  end
  
  resources :sections do
    resources :subscriptions, :only => [:create, :destroy]
    get 'subscribe', :controller => 'subscriptions', :action => 'create'
    get 'unsubscribe', :controller => 'subscriptions', :action => 'destroy'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
