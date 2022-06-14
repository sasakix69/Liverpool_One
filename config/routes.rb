# frozen_string_literal: true

Rails.application.routes.draw do
  root 'tops#index'
  get 'tops/show'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
