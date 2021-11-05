Rails.application.routes.draw do
  root "pages#new"
  get 'pages/home', 'pages#home'


  #to make routes available
  resources :recipes


end
