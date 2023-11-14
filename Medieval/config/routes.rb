Rails.application.routes.draw do
  get "/masters", to: "masters#new"
  resources :masters

  resources :quests

  get "/items", to: "items#new"
  resources :items

  get "/steps", to: "steps#new"
  resources :steps

  resources :players do
    collection do
      get 'connexion', to: 'players#connexion', as: 'connexion'
      get 'inscription', to: 'players#new', as: 'inscription'
      post 'authenticate', to: 'players#authenticate', as: 'authenticate'
    end
  end

  resources :sessions, only: [:create, :destroy]
end
