Rails3BootstrapDeviseCancan::Application.routes.draw do
  resources :couriers_tasks

  resources :couriers_companies

  resources :clients

  resources :documents_nal_prihods

  resources :documents_nal_rashods

  resources :documents_beznal_rashods

  resources :document_beznal_schets

  resources :company_members

  resources :companies

  resources :events

  authenticated :user do
    root :to => 'home#index'
  end
  
  root :to => "home#index"
  devise_for :users
  resources :users
end