# coding:utf-8
class Cpanel::CustomersController < Cpanel::BaseController
  before_filter :find_customer, only: [:edit, :show, :update, :destroy]
  def index
    @customers = Customer.paginate(:page => params[:page], :per_page => 6)
  end
  
  def show
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      flash[:success] = "添加商家成功."
      redirect_to cpanel_customers_url
    else
      render 'new'
    end
    
  end
  
  def edit
    
  end
  
  def update
    if @customer.update_attributes(params[:customer])
      flash[:success] = "商家资料更新成功."
      redirect_to cpanel_customers_url
    else
      render :edit
    end
    
  end
  
  private 
  
  def find_customer
    @customer = Customer.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "未找到该记录."
    redirect_to cpanel_customers_url
  end
  
end
