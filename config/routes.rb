Rails.application.routes.draw do
  get 'sessions/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :monsters, only: [:index, :show]
  root 'users#index'
  resources :users, only: [:index, :show,:edit, :update]
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :weapons, only: [:index, :show]
end
