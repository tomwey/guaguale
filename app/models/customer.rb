class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :tel, :address, :comp_name, :info, :email,  :remember_me
  # attr_accessible :title, :body
  
  TELPATTERN = /\d{3}-\d{8}|\d{4}-\d{7}/
  
  validates :name, presence: true
  validates :tel, presence: true, format: {with:TELPATTERN}, uniqueness: true
  validates :comp_name, presence: true
  validates :info, presence: true
  validates :address, presence: true
  
  has_many :tickets
  
  before_validation :set_default_password
  
  private
  
  def set_default_password
    self.password = "123456"
    self.password_confirmation = "123456"
  end
  
end
