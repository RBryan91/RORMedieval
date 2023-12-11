Rails.application.routes.draw do

  get "/masters", to: "masters#login"
  get "/logoutMaster", to: "masters#logout"
  get '/hdv', to: 'hdvs#index', as: 'hdv'
  post 'authenticateMaster', to: 'masters#authenticate'
  resources :masters do
    get 'login', on: :collection
  end
  resources :quests 
  resources :items
  resources :steps
  resources :characters
  resources :inventorys


  get ":players", to: "players#login"
  get "/logoutPlayer", to: "players#logout"
  post 'authenticatePlayer', to: 'players#authenticate'
  resources :players do
    get 'login', on: :collection
  end
end
