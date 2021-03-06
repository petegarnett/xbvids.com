Rails.application.routes.draw do
  get 'sitemap.xml' => 'sitemap#xml', defaults: { format: :xml }

  get 'user/:user_id' => 'public#user', as: 'user'

  get 'user/:user_id/screenshots/:screenshot_id' => 'public#user_screenshots_view', as: 'user_screenshot'
  get 'user/:user_id/screenshots' => 'public#user_screenshots_list', as: 'user_screenshots'

  get 'clip/:clip_id' => 'public#clip', as: 'clip'
  get 'clip/:clip_id/twitter_container' => 'public#clip_twitter_container', as: 'twitter_player_container'
  get 'game/:game_id' => 'public#game', as: 'game'

  post 'clip/:clip_id/vote' => 'public#vote', as: 'vote'

  get 'popular' => 'public#popular', as: 'popular'

  get 'home' => 'public#home', as: 'home'
  get 'users' => 'public#users', as: 'users'
  get 'games' => 'public#games', as: 'games'

  root 'public#home'

  get 'dashboard' => 'dashboard#index', as: 'dashboard'
  get 'profile' => 'dashboard#profile'
  post 'profile' => 'dashboard#profile_post', as: 'profile_post'

  get 'feed/twitter', defaults: { format: :xml }, as: 'twitter_feed'

  get 'faq' => 'public#faq', as: 'faq'

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
