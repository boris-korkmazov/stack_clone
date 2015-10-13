require 'sidekiq/web'

Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  root to: "questions#index"

  mount Sidekiq::Web => '/sidekiq'

  concern :commentable do
    resources :comments
  end


  resources :questions, concerns: :commentable, shallow: true do
    resources :answers, concerns: :commentable
  end

  namespace :api do
    namespace :v1 do
      resources :profiles do
        get :me, on: :collection
      end
      resources :questions
    end
  end
end
