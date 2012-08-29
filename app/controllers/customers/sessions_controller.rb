class Customers::SessionsController < Devise::SessionsController
  layout 'merc_login'
  
  def after_sign_in_path_for(resource)
    if current_customer
      stored_location_for(resource) || dashboard_root_path
    else
      merc_path
    end
  end
  
  def after_sign_out_path_for(resource)
    merc_path
  end
  
end