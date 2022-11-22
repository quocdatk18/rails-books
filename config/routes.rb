  # frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /en|vi/ do
    # define routes here
    root 'home#index'
    devise_for :admin, path_names: { sign_in: 'login', sign_out: 'logout' },
                       controllers: { sessions: 'admin/sessions' }
    devise_for :users, path_names: { sign_in: 'login', sign_up: 'register', sign_out: 'logout', password: 'secret' }
    resources :books, only: %i[index show]
    resources :books do
      resources :comments, except: %i[index show new]
    end
    resources :book_borrows, only: %i[index create update]
    namespace :admin do
      get '/dashboard', to: 'dashboard#index'
      resources :categories
    end
  end
end
