ActionController::Routing::Routes.draw do |map|
  map.resource :session
  map.resource :account, :member => { :beta => :any }  
  map.resources :subscriptions, :only => [:index]
  
  map.resources :subjects
  
  map.resources :instructors do |instructor|
    instructor.resources :comments, :except => [:index], :controller => "instructors_comments"
    instructor.resources :votes, :only => [:up, :down]
    instructor.up "/up", :controller => "instructors_votes", :action => "up"
    instructor.down "/down", :controller => "instructors_votes", :action => "down"
  end
  
  map.resources :courses do |course|
    course.resources :comments, :except => [:index], :controller => "courses_comments"
    course.resources :votes, :only => [:up, :down]
    course.up "/up", :controller => "courses_votes", :action => "up"
    course.down "/down", :controller => "courses_votes", :action => "down"
  end
  
  map.resources :sections do |section|
    section.resources :subscriptions, :only => [:create, :destroy]
    section.subscribe "/subscribe", :controller => "subscriptions", :action => "create"
    section.unsubscribe "/unsubscribe", :controller => "subscriptions", :action => "destroy"
  end
  
  map.search "/search", :controller => "search", :action => "index"
  map.login "/login", :controller => "sessions", :action => "new", :conditions => { :method => :get }
  map.login "/login", :controller => "sessions", :action => "create", :conditions => { :method => :post }  
  map.logout "/logout", :controller => "sessions", :action => "destroy"
  map.signup "/signup", :controller => "accounts", :action => "new", :conditions => { :method => :get }
  map.signup "/signup", :controller => "accounts", :action => "create", :conditions => { :method => :post }
  # map.beta "/beta", :controller => "accounts", :action => "beta"
  map.help "/help", :controller => "sissed", :action => "help"
  map.root :controller => "sissed", :action => "index"

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end
