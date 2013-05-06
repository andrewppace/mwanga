Mwanga::Application.routes.draw do
  resources :relationships


  get "confirm/email"

  resources :emails

  match "login" => "sessions#new"
  match "logout" => "sessions#destroy"

  match "signup" => "users#new"
  match "account" => "users#show"
  match "create" => "users#create"
  match "edit" => "users#edit"
  match "update" => "users#update"
  
  resources :profiles, only: [:new, :create, :edit, :update, :destroy]
  
  match "privacy/edit" => "privacy#edit"
  match "privacy/update" => "privacy#update"
  
  match "confirm/email/:email_confirmation_salt" => "confirm#email"
  
  resources :contacts do
    resources :emails
    resources :addresses
  end
  
  resources :invitations
  resources :requests
  resources :connections
  
  match "myinfo" => "contacts#myinfo"
  
  root to: "pages#home"
end
