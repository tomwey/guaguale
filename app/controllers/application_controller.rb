class ApplicationController < ActionController::Base
  protect_from_forgery
    
  # Handle CanCan Access Exception
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  
  def after_sign_in_path_for(resource)
    if current_user.admin?
      cpanel_root_path
    else
      root_path
    end
  end
    
end
