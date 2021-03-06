# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'posts#index'
  get 'posts', to: 'posts#new'
  post 'posts', to: 'posts#create'
  delete 'posts', to: 'posts#destroy'
  get 'user', to: 'users#show'
  get 'users', to: 'users#index'
  post 'comments', to: 'comments#create'
  delete 'comments', to: 'comments#destroy'
  post 'likes_post', to: 'likes#create'
  post 'likes_comment', to: 'likes#create'
  delete 'likes', to: 'likes#destroy'
  post 'friendship', to: 'friendships#create'
  post 'accept_friendship', to: 'friendships#update'
  delete 'cancel_friendship', to: 'friendships#destroy'
  get 'all_requests', to: 'friendships#show'
  get 'post', to: 'posts#show'
  resources :posts, only: %i[create new destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
