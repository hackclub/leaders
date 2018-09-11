require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root to: 'static_pages#index'

  resources :users, only: [] do
    collection do
      get 'auth', to: 'users#auth'
      post 'login_code', to: 'users#login_code'
      post 'exchange_login_code', to: 'users#exchange_login_code'
      delete 'logout', to: 'users#logout'
    end
  end

  resources :clubs, only: [:index, :show], param: :slug

  resources :subdomains, only: [:create, :update], param: :slug do
    resources :change_requests, only: [:create, :update, :index, :show]
  end
end
