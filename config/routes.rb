Rails.application.routes.draw do
  resources :items
  resources :projects
  resources :organizations
  root 'organizations#home'
  get 'search_organization', to: 'organizations#search'
  get 'dashboard', to: 'pages#home'

  devise_for :admins, controllers: {sessions: "sessions", invitations: "invitations"} 
  devise_for :members, controllers: {sessions: "sessions", invitations: "invitations"}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
