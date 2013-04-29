Mwanga::Application.routes.draw do
  resources :emails

  match "login" => "sessions#new"
  match "logout" => "sessions#destroy"

  match "signup" => "users#new"
  match "account" => "users#show"
  match "create" => "users#create"
  match "edit" => "users#edit"
  match "update" => "users#update"
  
  resources :profiles
  
  match "privacy/edit" => "privacy#edit"
  match "privacy/update" => "privacy#update"
  
  resources :contacts do
    resources :emails
  end
  
  root to: "pages#home"
end
