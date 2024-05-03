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


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
