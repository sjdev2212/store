Rails.application.routes.draw do
  root 'home#home'

get 'items/:category', to: 'items#filter'
  resources :items
end
