Guaguale::Application.routes.draw do
  
  namespace :api do 
    namespace :v1 do
      resources :tickets, :only => :index
    end
  end
  
  devise_for :customers, :path => 'merc', 
             :path_names => { :sign_in => 'login', :sign_out => 'logout' },
             :controllers => { :registrations => "customers/registrations",  
                               :sessions => 'customers/sessions' }  
  match '/merc/edit' => 'customers/passwords#edit', :as => 'edit_merc', :via => :get
  
  devise_for :users, 
             :path => 'account', 
             :path_names => { :sign_in => 'login', :sign_out => 'logout' },
             :controllers => { :registrations => "users/registrations",
                               :sessions => 'users/sessions' }
  
    
  root :to => redirect('/account/login')
  
  match '/merc' => redirect('/merc/login'), :as => 'merc'
  # match '/merc/dashboard' => 'customers#dashboard', :as => 'dashboard'
  
  namespace :dashboard do
    root to:'customers#index'
    
    match 'tickets/active' => 'tickets#active', :via => :put, :as => :active_ticket
    
    resources :tickets do
      get 'actived', :on => :collection
    end
  end
  
  namespace :cpanel do
    
    root to:'home#index'
    
    resources :tickets do 
      collection do
        get 'search'
      end
      
    end
    resources :customers
  end
  
  # mount Resque::Server, :at => '/resque'

end
