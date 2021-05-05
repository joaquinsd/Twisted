Rails.application.routes.draw do
  resources :likes
  resources :tweets
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'tweets#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
      }
end
