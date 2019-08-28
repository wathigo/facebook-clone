Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  get     'posts',      to: 'posts#new'
  post    'posts',      to: 'posts#create'
  get     '/user',       to: 'users#show'
  resources :posts, only: %i[create new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
