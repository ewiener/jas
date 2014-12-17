Ptast::Application.routes.draw do
  root :to => "home#index"

  resources :user_sessions, :only => [:create]
  resources :programs, :shallow => true do
  	member do
  		get 'home', :as => 'home_of'
  	end
  	resources :users
	  resources :semesters, :shallow => true do
	  	member do
	  		get 'switch'
	  		get 'home', :as => 'home_of'
        get 'invoices', :to => 'invoices#semester_index', :as => 'invoices_for'
	  		put 'import'
	  		delete 'days_off', :action => :delete_days_off, :as => 'days_off_for'
	  	end
	    resources :courses do
	      member do
	      	get 'fee', :action => :fee, :as => 'fee_for'
	  		  get 'calculate_meetings', :as => 'calculate_meetings_for'
	      end
	    end
	    resources :classrooms
	    resources :instructors, :shallow => true do
        resources :invoices
      end
	    resources :students do
	      member do
	      	get 'index_enrollments', :as => 'enrollments_for'
	      	get 'show_enrollment', :as => 'show_enrollment_for'
	      	get 'new_enrollment', :as => 'new_enrollment_for'
	      	get 'edit_enrollment', :as => 'edit_enrollment_for'
	        post 'create_enrollment', :as => 'create_enrollment_for'
	        post 'update_enrollment', :action => 'create_enrollment', :as => 'update_enrollment_for'
	        post 'destroy_enrollment', :as => 'destroy_enrollment_for'
	      end
	    end
	    resources :enrollments, :only => [:index]
	    resources :reports, :only => [:index, :show]
	  end
	end

  match '/login' => 'user_sessions#new', :as => 'login'
  match '/logout' => 'user_sessions#destroy', :as => 'logout'

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
