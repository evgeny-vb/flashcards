Rails.application.routes.draw do
  root 'home#index'

  resources :users, only: %i[new create edit update]
  resources :user_sessions, only: %i[new create destroy]

  get 'login', to: 'user_sessions#new', as: :login
  post 'logout', to: 'user_sessions#destroy', as: :logout

  resources :cards, except: :show
  post 'card_check_original_text', to: 'cards#check_original_text'

  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
