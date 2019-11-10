# frozen_string_literal: true

Rails.application.routes.draw do
  get 'welcome', to: 'welcome#index'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_in/:token', to: 'sessions#show', as: :token_sign_in

  root to: 'welcome#index'
end
