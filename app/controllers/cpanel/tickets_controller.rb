# encoding:utf-8
class Cpanel::TicketsController < Cpanel::BaseController
  
  load_and_authorize_resource
  
  before_filter :find_ticket, :only => [:show, :edit, :update, :destroy]
  def index
    @tickets = Ticket.order("created_at desc").paginate(page: params[:page], per_page: 5)
  end
  
  def show
  end
  def new
    @ticket = Ticket.new
  end
  
  def search
    @tickets = Ticket.order("created_at desc")
                     .search(params[:search])
                     .paginate(:page => params[:page], :per_page => 5)
    render :action => 'index'
  end

  def edit
  end
  
  def create
    @ticket = Ticket.new(params[:ticket])
    if @ticket.save
      flash[:success] = '奖券添加成功!!!'
      redirect_to cpanel_tickets_url 
    else
      render "new"
    end
  end
  
  def update
    if @ticket.update_attributes(params[:ticket])
      flash[:success] = '奖券更新成功!!!'
      redirect_to cpanel_tickets_url
    else
      render "edit"
    end
  end
  
  def destroy
    
    @ticket.destroy
    flash[:success] = "奖券删除成功!!!"
    redirect_to cpanel_tickets_url
  end
  
  private 
  
  def find_ticket
    @ticket = Ticket.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "奖券没有找到!!!"
    redirect_to cpanel_tickets_url
  end
end
