Rails.application.routes.draw do
  root 'home#index'

  resources :users, only: %i[new create edit update]
  resources :user_sessions, only: %i[new create destroy]

  get 'login', to: 'user_sessions#new', as: :login
  post 'logout', to: 'user_sessions#destroy', as: :logout

  scope '/dashboard' do
    resources :packs do
      member do
        post 'set_as_current'
      end
      resources :cards, shallow: true, except: %i[index show]
    end
    post 'card_check_original_text', to: 'cards#check_original_text'
  end

  get 'home/index'
  put 'home/locale'

  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
