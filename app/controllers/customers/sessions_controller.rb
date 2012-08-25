class Customers::SessionsController < Devise::SessionsController
  layout 'customer'
  
  def after_sign_in_path_for(resource)
    if current_customer
      stored_location_for(resource) || "/merc/dashboard"
    else
      merc_path
    end
  end
  
  def after_sign_out_path_for(resource)
    merc_path
  end
  
end