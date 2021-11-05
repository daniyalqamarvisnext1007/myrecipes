Rails.application.routes.draw do
  root "pages#home"
  get 'pages/home', 'pages#home'


  #to make routes available
  resources :recipes


  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]


end
