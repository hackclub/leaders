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

  resources :clubs, only: [:index, :show], param: :slug, shallow: true do
    resources :meetings, except: :index
  end
  resources :subdomains, param: :slug
  resources :dns_records

  resources :posts, path: 'marketing'
end
