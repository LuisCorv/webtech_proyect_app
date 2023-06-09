Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "pages#home"

  

  get '/tickets/search', to: 'tickets#search'
  resources :users do

    resources :ticket_lists do
      resources :tickets 

    end

    resources :assign_tickets do
      resources :tickets do
        resources :tag_lists do
          resources :tags
        end
        resources :chats do
          resources :comments
        end
      end
    end

    resources :tickets do
      resources :tag_lists do
        resources :tags
      end
      resources :chats do
        resources :comments
      end
    end

    resources :performance_reports

    get '/ticket_reports', to: 'tickets#ticket_report' , as: 'ticket_report'
    get '/overdue_reports', to: 'tickets#overdue_report', as: 'overdue_report'

  end
  resources :ticket_lists
  resources :assign_tickets
  resources :tickets
  resources :comments
  resources :chats
  resources :tags
  resources :tag_lists
  resources :performance_reports
  
  

  

  end
