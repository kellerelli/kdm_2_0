Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :monsters
  resources :items, :only =>[:index,:show]
  root 'users#index'
  resources :users

end
