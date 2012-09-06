class Customers::RegistrationsController < Devise::RegistrationsController
  layout 'customer'
  
  protected
  
  def after_update_path_for(resource)
    dashboard_active_url
  end
  
end