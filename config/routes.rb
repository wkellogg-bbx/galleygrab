ActionController::Routing::Routes.draw do |map|
  
	map.resources :users
  map.resource :session
  
  map.resources :site_reviews
  map.resources :covers
  map.resources :orders, :has_many => :site_reviews

  map.resources :books
  
  map.root :controller =>'orders',  :action => 'welcome'
  map.confirmation '/confirmation/:id', :controller => 'orders', :action => 'confirmation'
  map.catalog '/catalog', :controller => 'orders', :action => 'catalog'
	map.cart '/cart', :controller => 'orders', :action => 'cart_filled'
	
	
	map.namespace :admin do |admin|
  	admin.resources :books
  	admin.resources :orders, :has_many=>:site_reviews
  	admin.resources :site_reviews
  	admin.resources :home
  	admin.counts 'counts', :controller =>'home',  :action => 'counts'
  	admin.data_export_form 'data_export_form', :controller =>'home',  :action => 'data_export_form'
  	admin.data_export 'data_export', :controller =>'home',  :action => 'data_export'
  	admin.root :controller =>'home',  :action => 'index'
	end
	
	map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'

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

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
