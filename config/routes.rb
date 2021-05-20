Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tweets
  post 'tweets/:id/like', to: 'tweets#like', as: 'tweet_like'
  post 'tweets/:id/retweet', to: 'tweets#retweet', as: 'tweet_retweet'
  root 'tweets#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
      }

  devise_scope :user do
    post '/users/:id/friend', to: 'users/registrations#friend', as: 'user_friend'
  end

  namespace :api do
    get 'news', to: 'api#news'
    get ':start_date/:end_date', to: 'api#inbetween', as: 'inbetween'
    post 'create', to: 'api#create'
  end
end
