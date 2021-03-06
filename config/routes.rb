TYML::Application.routes.draw do

  root :to => 'Users#dashboard'

  devise_scope :user do
    delete '/sign-out', :controller => 'devise/sessions', :action => 'destroy', :as => 'destroy_user_session'
    get '/signup', :controller => 'devise/registrations', :action => 'new', :as => 'new_user_registration'
  end

  devise_for :users

  # SIGN-OUT

  get '/dashboard', :controller => 'Users', :action => 'dashboard', :as => 'dashboard'

  get '/dashboard/sent', :controller => 'Users', :action => 'sent', :as => 'sent'

  get '/dashboard/contacts', :controller => 'Users', :action => 'contacts', :as => 'contacts'

  resources :comments, :only => :create

  match "users/dashboard" => redirect("/dashboard")

  get "/settings", :controller => 'Users', :action => 'edit', :as => 'edit_user'

  match "users/:id/edit" => redirect("/settings")

  put '/tymls/:id/mark_as_read_or_unread', :controller => 'tymls', :action => 'mark_as_read_or_unread', :as => 'mark_as_read_or_unread'

  put '/tymls/:id/archive', :controller => 'tymls', :action => 'archive', :as => 'archive'

  resources :tymls

  resources :users

  get '/faq', :controller => 'Statics', :action => 'faq', :as => 'faq'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
