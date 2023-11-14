Rails.application.routes.draw do

  root "masters#index"

  get "/masters", to: "masters#new"
  resources :masters

  resources :quests
 
  get "/items", to: "items#new"
  resources :items

  get "/steps", to: "steps#new"
  resources :steps

end

