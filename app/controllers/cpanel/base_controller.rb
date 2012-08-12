
class Cpanel::BaseController < ApplicationController
  before_filter :authenticate_user!
  
  layout "cpanel"
end
