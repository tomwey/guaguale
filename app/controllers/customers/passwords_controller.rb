class Customers::PasswordsController < ApplicationController
  before_filter :authenticate_customer!
  layout 'customer'
  
  def edit
    @customer = current_customer
  end
  
  def update
    @customer = current_customer
    
    if @customer.update_with_password(params[:customer])
      sign_in(@customer, :bypass => true)
      flash[:notice] = "密码修改成功."
      redirect_to dashboard_active_path
    else
      render :edit 
    end
  end
  
end