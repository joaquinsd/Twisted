Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tweets
  post 'tweets/:id/like', to: 'tweets#like', as: 'tweet_like'
  post 'tweets/:id/retweet', to: 'tweets#retweet', as: 'tweet_retweet'
  root 'tweets#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
      }
end
