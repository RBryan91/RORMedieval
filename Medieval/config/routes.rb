Rails.application.routes.draw do

  get "/masters", to: "masters#login"
  get "/logout", to: "masters#logout"
  post 'authenticate', to: 'masters#authenticate'
  resources :masters do
    get 'login', on: :collection
  end
  resources :quests 
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
