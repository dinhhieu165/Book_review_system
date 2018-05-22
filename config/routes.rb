Rails.application.routes.draw do
  root "static_pages#home"

  post '/rate' => 'rater#create', :as => 'rate'
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"

  devise_for :users, controller: { omniauth_callbacks: "users/omniauth_callbacks"}

  resources :users do
    resources :requests, only: %i[index new create destroy]
    member do
      get :following, :followers
    end
  end

  namespace :admin do
    root "books#index"
    resources :users
    resources :books
    resources :requests, only: %i[index  update]
    resources :categories
  end

  resources :categories, only: %i[show index]
  resources :activities, only: %i[show index]
  resources :books
  resources :reviews do
    resources :comments
  end
  resources :likes, only: %i[create edit]
  resources :marks
  resources :relationships, only: %i[create destroy]
end
