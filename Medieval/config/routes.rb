Rails.application.routes.draw do
<<<<<<< HEAD
  get "/masters", to: "masters#new"
  resources :masters

  resources :quests

  get "/items", to: "items#new"
=======

  get "/masters", to: "masters#login"
  get "/logout", to: "masters#logout"
  post 'authenticate', to: 'masters#authenticate'
  resources :masters do
    get 'login', on: :collection
  end
  resources :quests 
>>>>>>> f2ce67cc35a063e0bdf6d2c859780f5dbb741091
  resources :items
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
