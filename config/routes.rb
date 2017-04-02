Rails.application.routes.draw do

  # root 'start#home'
  root 'products#index'

  devise_for :users, controllers: {
    confirmations:      'users/confirmations',
    passwords:          'users/passwords',
    registrations:      'users/registrations',
    sessions:           'users/sessions',
    unlocks:            'users/unlocks'
  }

  resources :teams, only: [:new, :create, :destroy] do
    resources :memberships, only: [:index, :new, :create, :destroy]
  end
  post "/teams/switch/:id" => 'teams#switch', as: 'team_switch'

  resources :products, shallow: true do
    resources :projects, except: :index do
      resources :features, except: :index
    end
    resources :features, only: :index
  end

  post   '/product/:id' => 'active_products#create', as: 'active_product'
  get    '/product/:id' => 'active_products#show',   as: 'alt_product'
  delete '/product/all' => 'active_products#destroy'

  post   '/project/:id' => 'active_projects#create', as: 'active_project'
  get    '/project/:id' => 'active_projects#show',   as: 'alt_project'
  delete '/project/all' => 'active_projects#destroy'

  get '/complete' => 'completed_features#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'projects/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: project.id)
  #   get 'projects/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :projects

  # Example resource route with options:
  #   resources :projects do
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
  #   resources :projects do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :projects do
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
  #     # Directs /admin/projects/* to Admin::projectsController
  #     # (app/controllers/admin/projects_controller.rb)
  #     resources :projects
  #   end
end
