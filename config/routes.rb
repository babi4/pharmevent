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
  resources :users do
    put 'change_pass', :on => :member
  end

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"

  get "/auth", :to => "auth#new", :as => 'new_user_session'
  post "/auth", :to => "auth#create", :as => 'user_session'
  delete "/sign_out", :to => "auth#destroy", :as => 'destroy_user_session'

  devise_for :user, :skip => [:sessions, :passwords]
end
