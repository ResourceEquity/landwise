require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  root to: 'home#index'
  
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  resources :api,        only: [:create]
  resources :home,       only: [:index]
  resources :library,    only: [:index]
  resources :admin,      only: [:index]
  resources :favorites,  only: [:create, :destroy]
  resources :records,    only: [:index, :show]
  resources :documents,  only: [:show]
  resources :guides,     only: [:index, :show] do
    resources :articles, only: [:show]
  end

  resources :example, only: [:index]

  get '/example1', to: 'example#example1'
  get '/example2', to: 'example#example2'
  get '/example3', to: 'example#example3'

  namespace :admin do
    resources :pages
    resources :users
    resources :roles
    resources :links
    resources :topics
    resources :tokens
    resources :guides
    resources :imports
    resources :records
    resources :subjects
    resources :redirects
    resources :languages
    resources :countries
    resources :categories
    resources :jurisdictions
  end

  match '/record/:id', to: 'records#show', via: :get

  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#unprocessable_entity', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web      => '/sidekiq'
    mount Ckeditor::Engine  => '/ckeditor'
  end

  get '*path', to: 'cms#show', constraints: lambda { |request| request.path.exclude?('rails/active_storage') }

end
