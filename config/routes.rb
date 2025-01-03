Rails.application.routes.draw do
  root 'home#home'
  
  get 'items/cat/:category' , to: 'items#filter'
  resources :items

end
