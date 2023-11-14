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

end

