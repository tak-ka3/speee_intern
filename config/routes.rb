# frozen_string_literal: true

Rails.application.routes.draw do
  get '/home' , to: 'user_pages#home' # userのhome画面
  get '/agree', to: 'user_pages#agree' # 鍵などの合意画面
  
  namespace :admin do
    root to: 'admin_pages#home'
    get 'question', to: 'admin_pages#question'
    # resources :candidates
    get 'candidates', to: 'candidates#new'
    post 'candidates', to: 'candidates#create'
    get 'candidates/show', to: 'candidates#show'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  mount KomachiHeartbeat::Engine => '/ops'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  resources :users, only: %i[show]

  devise_for :admin_users, controllers: {
    sessions: 'admin_users/sessions',
    passwords: 'admin_users/passwords',
    registrations: 'admin_users/registrations'
  }
end
