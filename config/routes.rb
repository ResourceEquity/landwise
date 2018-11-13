Rails.application.routes.draw do

  root to: 'home#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :home,       only: [:index]
  resources :library,    only: [:index]
  resources :admin,      only: [:index]
  resources :favorites,  only: [:create, :destroy]
  resources :records,    only: [:index, :show]
  resources :guides,     only: [:index, :show] do
    resources :articles, only: [:show]
  end

  namespace :admin do
    resources :pages
    resources :users
    resources :roles
    resources :topics
    resources :guides
    resources :records
    resources :subjects
    resources :redirects
    resources :languages
    resources :countries
    resources :categories
    resources :jurisdictions
  end

  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#unprocessable_entity', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  get '*path', to: 'cms#show', constraints: lambda { |request| request.path.exclude?('rails/active_storage') }

end
