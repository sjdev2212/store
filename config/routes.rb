Rails.application.routes.draw do
  devise_for :users
  root 'home#home'
  
  get 'items/cat/:category' , to: 'items#filter'
  resources :items

end
