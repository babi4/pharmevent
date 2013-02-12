Rails3BootstrapDeviseCancan::Application.routes.draw do

  resources :company_consumptions, :only => [:index]

  resources :company_beznal_rashods, :path => "/events/0/documents_beznal_rashods" do
    member { put 'update_state' }
  end

  resources :company_nal_rashods, :path => "/events/0/documents_nal_rashods" do
    member { put 'update_state' }
  end


  resources :events do
    resources :documents_beznal_rashods,
              :documents_nal_prihods,
              :documents_nal_rashods,
              :documents_beznal_schets do
      member { put 'update_state' }
    end

    get 'archive', :on => :collection
    post 'switch_archive', :on => :member
  end

  resources :companies do
    resources :company_members
  end

  resources :clients
  resources :couriers_tasks
  resources :couriers_companies do
    resources :couriers_company_members, :only => [:index, :create, :update, :destroy]
  end

  resources :users do
    put 'change_pass', :on => :member
  end

  authenticated :user do
    root :to => 'events#index'
  end
  root :to => "home#index"

  get "/auth", :to => "auth#new", :as => 'new_user_session'
  post "/auth", :to => "auth#create", :as => 'user_session'
  delete "/sign_out", :to => "auth#destroy", :as => 'destroy_user_session'

  devise_for :user, :skip => [:sessions, :passwords]
  mount RailsAdmin::Engine => '/rails_admin', :as => 'rails_admin'

  match 'company_members/update' => 'company_members#update'
  match 'company_members/destroy' => 'company_members#destroy'

  match 'reports' => 'reports#index'
  match 'new_password' => 'users#new_password', :as => 'change_password'

  match 'documents' => 'documents#index', :as => 'documents'

  match 'couriers_tasks/create_member' => 'couriers_tasks#create_member', :via => :post
  match 'couriers_companies/:company_id/couriers_company_members/create' => 'couriers_company_members#create'

end
