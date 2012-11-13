Rails3BootstrapDeviseCancan::Application.routes.draw do

  resources :events
  resources :companies do
    resources :company_members
  end
  resources :clients


  resources :couriers_tasks
  resources :couriers_companies
  resources :documents_nal_prihods
  resources :documents_nal_rashods
  resources :documents_beznal_rashods
  resources :document_beznal_schets


  authenticated :user do
    root :to => 'home#index'
  end
  
  root :to => "home#index"
  devise_for :users
  resources :users
end
