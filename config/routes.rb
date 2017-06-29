Zaftool::Application.routes.draw do
  get "password_resets/new"
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  get "maintenance/lookup" => 'model_year_services#lookup', :as => :maintenance_lookup
  
  resources :feature_requests,                     only: [:create]
  resources :sessions,                             only: [:new, :create, :destroy]
  resources :microposts,                           only: [:create, :destroy]
  resources :user_user_relationships,              only: [:create, :destroy]
  resources :password_resets,                      only: [:new, :create, :edit, :update]
  resources :makes,                                only: [:show, :index]
  resources :models,                               only: [:show, :index]
  resources :model_years,                          only: [:show, :index], path: 'bikes'
  resources :model_year_services,                  only: [:show, :index], path: 'maintenance'
  resources :model_year_service_requirement_votes, only: [:create, :destroy]
  resources :user_vehicles,                        path: 'garage'
  resources :model_year_service_update_requests,   only: [:create, :destroy]
  resources :model_year_update_requests,           only: [:create, :destroy]
  resources :contacts,                             only: [:new, :create]
  resources :model_year_service_interval_votes,    only: [:create, :destroy]
  resources :votes,                                only: [:create]
  resources :user_requirement_items,               path: 'toolbox'
  resources :model_year_service_requirements,      only: [:new, :create, :destroy, :edit, :update, :show]
  resources :model_year_service_specifications,    only: [:new, :create, :edit, :update, :show]
  resources :specifications,                       only: [:new, :create, :edit, :update, :show]
  resources :services,                             only: [:index]
  
  get "makes/:make_id/models" => "models#index_for_make",
                                 :as => "models_for_make", 
                                 :format => :json
  get "models/:model_id/model_years" => "model_years#index_for_model",
                                        :as => "model_years_for_model",
                                        :format => :json
  get "model_years/:model_year_id/model_year_services" => "model_year_services#index_for_model_year",
                                        :as => "model_year_services_for_model_year",
                                        :format => :json
  get "user_vehicles/add_to_garage" => 'user_vehicles#add_to_garage', :as => :add_to_garage
  get "model_year_services/:id/interval" => "model_year_services#edit_interval",
                                        :as => :edit_model_year_service_interval
  patch "model_year_services/:id/interval" => "model_year_services#update_interval",
                                        :as => :update_model_year_service_interval
 
  root 'static_pages#home'
  match '/help',     to: 'static_pages#help',    via: 'get'
  match '/about',    to: 'static_pages#about',   via: 'get'
  match '/contact',  to: 'contacts#new',         via: 'get'
  match '/signup',   to: 'users#new',            via: 'get'
  match '/signin',   to: 'sessions#new',         via: 'get'
  match '/contacts', to: 'contacts#new',         via: 'get'
  match '/garage',   to: 'user_vehicles#index',  via: 'get'
  match '/toolbox',  to: 'user_requirement_items#index', via: 'get'
  match '/toolbox_quick_add',  to: 'user_requirement_items#quick_add', via: 'post'
  match '/signout',  to: 'sessions#destroy',     via: 'delete'
  match '/load',     to: 'model_year_services#show_from_dropdown', via: 'get'
  match '/load_default_requirements',
        to: 'model_year_services#load_default_requirements',
        via: 'patch'
  

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
