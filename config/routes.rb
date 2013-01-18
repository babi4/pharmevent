Rails3BootstrapDeviseCancan::Application.routes.draw do

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

  resources :documents do
    collection do
      get :search
      post :search
    end
  end

  match 'couriers_companies/:company_id/couriers_company_members/create' => 'couriers_company_members#create'

end
