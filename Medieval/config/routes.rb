Rails.application.routes.draw do

  get "/masters", to: "masters#new"
  resources :masters

  resources :quests
 
  get "/items", to: "items#new"
  resources :items

  get "/steps", to: "steps#new"
  resources :steps

end

