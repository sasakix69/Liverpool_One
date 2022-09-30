# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'top#index'
  get 'top/show'
  get 'liverpool/index'
  get 'football/ranking'
  get 'football/schedule'
  post '/callback' => 'linebot#callback'

  # controllerを指定することで、指定内のcontrollerで記述する内容を有効に出来る
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }

  resources :users, only: %i[show] do
    member do
      get :bookmarks
      get :followings
      get :followers
    end
  end

  resources :tweets do
    resources :comments, only: %i[create update destroy], shallow: true
    collection do
      get :bookmarks
    end
  end

  resources :bookmarks, only: %i[create destroy]
  resources :news, only: %i[index]
  resources :notifications, only: %i[index]
  resources :relationships, only: %i[create destroy]
end
