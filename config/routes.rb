Guaguale::Application.routes.draw do
  
  namespace :api do 
    namespace :v1 do
      resources :tickets, :only => :index
    end
  end
  
  devise_for :customers, :path => 'merc', 
             :path_names => { :sign_in => 'login', :sign_out => 'logout' },
             :controllers => { :registrations => "customers", 
                               :sessions => 'customers/sessions' }  
  devise_for :users, 
             :path => 'account', 
             :path_names => { :sign_in => 'login', :sign_out => 'logout' },
             :controllers => { :sessions => 'users/sessions' }
  
    
  root :to => redirect('/account/login')
  
  match '/merc' => redirect('/merc/login'), :as => 'merc'
  match '/merc/dashboard' => 'customers#dashboard', :as => 'dashboard'
  
  namespace :cpanel do
    
    root to:'home#index'
    
    resources :tickets do 
      collection do
        get 'search'
      end
      
    end
    resources :customers
  end

end
