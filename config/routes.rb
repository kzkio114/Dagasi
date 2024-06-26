Rails.application.routes.draw do
  root 'top#index'
  post 'add_button', to: 'top#add_button'
  delete 'remove_buttons', to: 'top#remove_buttons'
  delete 'remove_specific_button/:id', to: 'top#remove_specific_button', as: 'remove_specific_button'
  get 'search_items', to: 'top#search_items'
  post '/add_to_cart/:id', to: 'carts#add_to_cart', as: 'add_to_cart'
  resources :top, only: [:index]
  get 'refresh_items', to: 'top#refresh_items', as: 'refresh_items'
  put 'replace_element/:id', to: 'top#replace_element', as: 'replace_element'
  # ランダム検索ページへのルート
  get 'items/random_search', to: 'items#random_search'
  resources :items
  post 'new_button', to: 'buttons#new', as: 'new_button'
  post 'items/create_or_find', to: 'items#create_or_find', as: 'create_or_find_item'
  get 'explanation', to: 'pages#explanation', as: 'explanation'

  get 'show_info', to: 'top#show_info', as: 'show_info_top_index'
  delete 'clear_info', to: 'top#clear_info', as: 'clear_info_top_index'

  resources :buttons
  post 'post', to: 'top#post', as: 'post_top_index'
  resources :top do
    collection do
      get :show_info
    end
  end

  resources :top do
    collection do
      delete :clear_info  # DELETE リクエストで説明をクリアするアクションへのルート
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
