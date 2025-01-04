Rails.application.routes.draw do
  devise_for :users
  root 'home#home'
  
  get 'items/cat/:category' , to: 'items#filter'
  get 'admin_panel' , to: 'home#admin_panel'
  resources :items

end
