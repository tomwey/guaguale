class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:tel]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :tel, :address, :comp_name,
                  :info, :email,  :remember_me, :password, :password_confirmation
  # attr_accessible :title, :body
  
  default_scope :order => 'created_at DESC'
  
  TELPATTERN = /^0{0,1}(13[0-9]|147|15[5-9]|15[0-3]|18[5-9]|180|182)[0-9]{8}$/
  
  validates :name, presence: true
  validates :tel, presence: true, format: { with:TELPATTERN }, uniqueness: true
  validates :comp_name, presence: true
  validates :info, presence: true
  validates :address, presence: true
  
  has_many :tickets, :dependent => :destroy
  
  before_validation :set_default_password
  
  private
  
  def set_default_password
    if new_record?
      generated_password = Devise.friendly_token.first(6)
      self.password = generated_password
      self.password_confirmation = generated_password
    end
  end
  
end
