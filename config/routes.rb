Rails.application.routes.draw do
  root 'home#index'

  resources :cards, except: :show
  post 'card_check_original_text', to: 'cards#check_original_text'

  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
