Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tweets do
    resources :likes, only: [:create, :destroy]
  end
  root 'tweets#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
      }
end
