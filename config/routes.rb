# frozen_string_literal: true

Rails.application.routes.draw do
  get 'sessions/new'
  get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #

  get 'welcome', to: 'welcome#index'
  get 'sign_in', to: 'sessions#new'

  root to: 'welcome#index'
end
