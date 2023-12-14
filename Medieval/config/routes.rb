Rails.application.routes.draw do

  root "application#index"

  get "/masters", to: "masters#login"
  get "/logoutMaster", to: "masters#logout"
  get '/hdv', to: 'hdvs#index', as: 'hdv'
  post 'authenticateMaster', to: 'masters#authenticate'
  resources :masters
  get '/delete_quest', to: 'quests#delete_quest', as: :delete_quest

  resources :quests 
  resources :items
  resources :steps
  resources :characters
  resources :inventorys
  resources :hdvs

  get '/start_quest', to: 'steps#startQuest', as: :startQuest
  get '/delete_character', to: 'characters#delete_character', as: :delete_character
  get '/buy_item', to: 'hdvs#buy_item', as: :buy_item
  get '/delete_item', to: 'hdvs#delete_item', as: :delete_item

  patch '/move_items', to: 'inventorys#move_items', as: :move_items

  get "/monsters", to: "monsters#new"
  resources :monsters

  get "/responses", to: "enigmes#responses"
  get "/enigmes", to: "enigmes#new"
  resources :enigmes

  get "/answers", to: "answers#new"
  resources :answers

  get "/players", to: "players#connect"
  get "/logoutPlayer", to: "players#logout"
  post 'authenticatePlayer', to: 'players#authenticate'
  resources :players
end
