Rails.application.routes.draw do
  resources :performance_reports
  resources :tags
  resources :comments
  resources :tag_lists
  resources :chats
  resources :assign_tickets
  resources :ticket_lists
  resources :users
  resources :tickets
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "pages#home"


  end
