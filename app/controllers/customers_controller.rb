# encoding:utf-8
class CustomersController < ApplicationController
  layout 'customer'
  
  before_filter :authenticate_customer!, except:[:home]
  
  def home
    
  end
  
  def dashboard
    
  end
  
end