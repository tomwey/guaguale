class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    if current_user.admin?
      stored_location_for(resource) || cpanel_root_path
    else
      root_path
    end
  end
end