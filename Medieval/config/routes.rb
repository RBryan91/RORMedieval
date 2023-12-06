Rails.application.routes.draw do

  get "/masters", to: "masters#new"
  resources :masters

  resources :quests
 
  get "/items", to: "items#new"
  resources :items

  get "/steps", to: "steps#new"
  resources :steps

  get "/monsters", to: "monsters#new"
  resources :monsters

  get "/enigmes", to: "enigmes#new"
  resources :enigmes

  get "/answers", to: "answers#new"
  resources :answers

end

