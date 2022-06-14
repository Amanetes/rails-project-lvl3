# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth

    resource :session, only: :destroy

    resources :bulletins, except: :destroy do
      member do
        patch :send_to_moderation
        patch :archive
      end
    end
    resource :profile, only: :show

    namespace :admin do
      root 'home#index'
      resources :bulletins, only: :index do
        member do
          patch :publish
          patch :reject
          patch :archive
        end
      end
      resources :categories, except: :show
    end
  end
end
