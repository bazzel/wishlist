# frozen_string_literal: true

Rails.application.routes.draw do
  get 'welcome', to: 'welcome#index'
  get 'sign_in', to: 'sessions#new'

  root to: 'welcome#index'
end
