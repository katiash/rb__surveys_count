Rails.application.routes.draw do
  
  get 'surveys' => "surveys#index"
  match 'surveys' => "surveys#create", via: [:post] 
  get 'surveys/index'
  match 'surveys/result(/:id)' => "surveys#result", via: [:get], as: 'surveys_result'
  # get 'surveys/result' => 'surveys#result', :your_name => 'Your name', :dojo_loc => 'Mountain View, CA', :fave_lang => 'Python', :comment => 'No comment here...''
  root 'surveys#index'
  match "/:ind" => redirect("surveys/index"), via: [:all], constraints: { ind: /[a-z]+/ }
  
  # SEEMS LIKE FOLLOWING USED TO BE TRUE back in 2012:
  # match "/*id" => "pages#show", constraints: { id: /company/ } # doesn't work
  # match "/*id" => "pages#show", id: /company/ # does work
  
  # match "*path" => redirect("/", status: 301), via: [:all]
  # match "*path" to: redirect("/", status: 301), via: [:all]

  # Will  transmit the default email and password and prefill the login form, 
  # but the url will just be .../test_login: 
  # get 'test_login' => 'sessions#new', :email => "the test email", :password => "the test password"

  # So you need a route that will match (in this particular case) everything after the second URI component.
  # You can do that with a route glob. You "glob" the route with an asterisk:
  #
  #       map.connect 'files/list/*specs'
  # Now, the files/list action will have access to an array of URI fields, accessible via params[:specs]:
  #       
  #       def list
  #         specs = params[:specs] # e.g, ["base", "books", "fiction", "dickens"]
  #       end
  # The glob has to come at the end of the pattern string in the route.

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
