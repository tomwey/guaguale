# encoding:utf-8
class Dashboard::CustomersController < ApplicationController
  layout 'customer'
  
  before_filter :authenticate_customer!, except:[:home]
  
  def home
    
  end
  
  def active
  end
  
  def verify
    @ticket = current_customer.tickets.find_by_token(params[:ticket][:token])
        
    if @ticket
      if @ticket.active
        flash[:notice] = '奖券已经激活，赶快去消费吧！！！'
      else
        if @ticket.expire_end_at.to_date < Time.now.to_date
          flash[:notice] = '奖券已过期'
        else
          if @ticket.update_attribute('active',true)
            flash[:success] = '奖券激活成功'
          else
            flash[:error] = '奖券激活失败，请重试。'
          end
        end
      end
    else
      flash[:error] = '没有找到相关的奖券'
    end
    
    redirect_to :action => 'active'
  end
  
  def actived_tickets
    @tickets = current_customer.tickets.actived.paginate(:page => params[:page],
                              :per_page => 5)
  end
  
end