Mapaddr::Application.routes.draw do

  resource :session, only: [:create, :destroy]

  resources :users, except: :new
  get 'welcome/' => 'users#new'

  # except :index after testing groups
  resources :groups, except: :new, shallow: true do
    resources :locations, except: [:index, :new]
  end

  # get 'groups/' => 'groups#index', as: :groups
  # get 'groups/:id' => 'groups#show', as: :group
  # post 'groups/' => 'groups#create'
  # get 'groups/:id/edit' => 'groups#edit', as: :edit_group
  # patch 'groups/:id' => 'groups#update'
  # delete 'groups/:id' => 'groups#destroy'

  # get 'users/new' => 'users#new', as: :new_user
  # get 'users/:id' => 'users#show', as: :user
  # post 'users/' => 'users#create'
  # get 'users/:id/edit' => 'users#edit', as: :edit_user
  # patch 'users/:id' => 'users#update'
  # delete 'users/:id' => 'users#destroy'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'users#index'

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
