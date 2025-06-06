Rails.application.routes.draw do
  get 'vegetables/index'
  get 'growing_steps/index'
  root 'posts#index'
  devise_for :users
  resources :posts
  resources :tags, only: [:show]

  get '/grow_logs', to: 'posts#index', defaults: { filter: 'grow_log' }, as: 'grow_logs'
  get '/troubles', to: 'posts#index', defaults: { filter: 'failure' }, as: 'troubles'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :posts do
    resources :comments, only: :create
    resources :likes, only: [:create, :destroy]
  end

  resources :vegetables, only: [:index] do
    resources :growing_steps, only: [:index]
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
