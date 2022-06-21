# frozen_string_literal: true

Rails.application.routes.draw do
  root 'tops#index'
  get 'tops/show'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
