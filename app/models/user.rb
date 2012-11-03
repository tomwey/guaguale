class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  validates :name, presence: true
  
  # EMAILS = ["tomwey@163.com", "493083207@qq.com"]
  
  # 是否是管理员
  def admin?
    #EMAILS.include?(self.email)
    return true if Settings.admin_emails.include?(self.email)
    return false
  end
  
  def merchant?
    self.admin? or self.verified == true
  end
  
  def has_role?(role)
    case role
    when :admin then admin?
    when :merchant then merchant?
    when :member then true
    else false
    end
  end
  
end
