# coding: utf-8
class CustomerMailer < ActionMailer::Base
  layout 'mailer'
  
  default from: Settings.email_sender
  default charset: "utf-8"
  default content_type: "text/html"
  default_url_options[:host] = Settings.domain
  # include Resque::Mailer
  
  def customer_notify_email(customer)
    @customer = customer
    @url = Settings.merc_login_url
    mail :to => @customer.email, :subject => "在#{Settings.app_name}成功创建了账号"
  end
  
end
