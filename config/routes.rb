Rails.application.routes.draw do
  root 'home#index'

  resources :cards, except: :show do
    collection do
      post :check_original
    end
  end

  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
