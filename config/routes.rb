Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :monsters, :only =>[:index,:show]
  resources :items, :only =>[:index,:show]

end
