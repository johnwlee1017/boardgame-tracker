Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#new'

  resource :sessions, only: [:new, :create, :destroy]
  resources :users do
    resources :boardgames
  end

end
