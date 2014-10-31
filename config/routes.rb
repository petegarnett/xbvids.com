Rails.application.routes.draw do
  get 'user/:user_id' => 'public#user', as: 'user'
  get 'clip/:clip_id' => 'public#clip', as: 'clip'
  get 'clip/:clip_id/twitter_container' => 'public#clip_twitter_container', as: 'twitter_player_container'

  get 'home' => 'public#home', as: 'home'
  get 'users' => 'public#users', as: 'users'
  get 'games' => 'public#games', as: 'games'

  root 'public#home'

  get 'dashboard' => 'dashboard#index', as: 'dashboard'
  get 'settings' => 'dashboard#settings'
  post 'settings' => 'dashboard#settings_post', as: 'settings_post'

  get 'feed/twitter', defaults: { format: :xml }, as: 'twitter_feed'

  devise_for :users

  namespace :api do
    namespace :v1 do
      get 'videos/firehose'
      get 'videos/mine'
    end
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
