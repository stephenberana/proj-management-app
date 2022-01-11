Rails.application.routes.draw do
  resources :user_projects
  put 'user_projects', to: "user_projects#create"
  resources :items
  resources :projects
  resources :organizations
  root 'organizations#home'
  get 'search_organization', to: 'organizations#search'
  get 'dashboard', to: 'pages#home'

  devise_for :admins, controllers: {sessions: "sessions", invitations: "invitations"} 
  devise_for :members, controllers: {sessions: "sessions", invitations: "invitations"}
  devise_for :users, controllers: {sessions: "sessions", registrations: "registrations"}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

match 'plan/edit' => 'organizations#edit', via: :get, as: :edit_plan
match 'plan/update' => 'organizations#update', via: [:put, :patch], as: :update_plan
end
