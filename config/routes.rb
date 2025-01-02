Rails.application.routes.draw do
  root 'home#home'
  resources :home
  resources :items
end
