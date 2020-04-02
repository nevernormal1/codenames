Rails.application.routes.draw do
  root to: 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :boards do
    member do
      get :updated_at
    end
  end
  resources :clues
  resources :guesses
end
