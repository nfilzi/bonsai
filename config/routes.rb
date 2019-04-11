require_relative 'routes/api_constraint'

Rails.application.routes.draw do
  root to: 'pages#home'

  namespace :api, defaults: { format: 'json' } do
    scope module: :v1, constraints: Routes::ApiConstraint.new(version: 1) do
      resources :plants, only: [:show, :index]
    end
  end

  devise_for :users

  resources :plants,      only: [:index, :show]
  resource  :leaderboard, only: [:show], controller: 'leaderboard'

  namespace :garden do
    root to: 'dashboard#show'

    resources :care_moments, only: [:index]

    resources :plants do
      resources :care_moments, only: [:create]
      resource :favorite, only: [:create], module: 'plants'
    end
  end
end
