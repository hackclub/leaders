require 'sidekiq/web'
require 'admin_constraint'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq', constraints: AdminConstraint.new
  get '/sidekiq', to: 'users#auth' # fallback if admin_constraint fails, meaning user is not signed in

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
  resources :subdomains, param: :slug, constraints: { slug: /[0-z\.]+/ }
  resources :dns_records

  resources :posts, path: 'marketing'
end
