require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root to: 'static_pages#index'

  resources :users, only: [:update] do
    collection do
      get 'auth', to: 'users#auth', as: :sign_in
      post 'login_code', to: 'users#login_code'
      post 'exchange_login_code', to: 'users#exchange_login_code'
      delete 'logout', to: 'users#logout'
    end
  end

  resources :clubs, only: [:index, :show], param: :slug
  resources :subdomains, param: :slug, constraints: { slug: /[0-z\.]+/ }
  resources :dns_records

  resources :posts, path: 'marketing'
end
