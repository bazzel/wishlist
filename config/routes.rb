# frozen_string_literal: true

Rails.application.routes.draw do
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_in/:token', to: 'sessions#show', as: :token_sign_in
  delete 'sign_out', to: 'sessions#destroy'

  resources :events, param: :slug do
    resources :articles, param: :slug, shallow: true do
      post 'restore', on: :member
    end
  end

  root to: 'events#index'
end
