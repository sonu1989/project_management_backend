Rails.application.routes.draw do
  devise_for :users
  #devise_for :users
  #devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      post 'login', to: 'auth#login'
      get 'profile', to: 'users#profile'
      resources :projects do

        member do
          get :tasks_breakdown
          post :assign_user
          post :remove_user
          get :tasks

        end
      end
      resources :tasks, only: [:create]
      resources :users, only: [:index]
    end
  end

end
