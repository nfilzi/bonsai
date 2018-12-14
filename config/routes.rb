Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users

  resources :plants,      only: [:index, :show]
  resource  :leaderboard, only: [:show], controller: 'leaderboard'

  namespace :garden do
    root to: 'dashboard#show'

    resources :care_moments, only: [:index]

    resources :plants do
      resources :care_moments, only: [:create]
    end
  end
end
