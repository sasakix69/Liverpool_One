# frozen_string_literal: true

Rails.application.routes.draw do
  root 'tops#index'
  get 'tops/show'
  get 'football/ranking'
  get 'football/schedule'

  # controllerを指定することで、指定内のcontrollerで記述する内容を有効に出来る
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  resources :users, only: [:show] do
    member do
      get :bookmarks
    end
  end

  resources :tweets do
    resources :comments, only: %i[create update destroy], shallow: true
    collection do
      get :bookmarks
    end
  end
  resources :bookmarks, only: %i[create destroy]

  resources :news, only: :index

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
