Rails.application.routes.draw do
  get '__healthcheck', to: 'healthcheck#show'

  root to: 'pages#home'

  resources :links
  resources :articles
  resources :article_series
  resources :projects
  resources :information

  namespace :projects do
    post "create_project_status", :to => "create_project_status"
    post "destroy_project_status", :to => "destroy_project_status"
  end

  # devise_for :users
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # devise以外
  # ログイン・パスワード関連でDeviseの機能を優先して利用するため、 users は必ず devise_for より下に記述
  resources :users
  
end
