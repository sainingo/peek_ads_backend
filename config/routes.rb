Rails.application.routes.draw do
 resources :sessions, only: [:login, :destroy]
 resources :users, only: [:create, :show]
end
