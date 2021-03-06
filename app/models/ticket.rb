# coding: utf-8
class Ticket < ActiveRecord::Base
  attr_accessible :expire_end_at, :expire_start_at, :avatar, :customer_id
  
  has_attached_file :avatar, :styles => { :large  => "600x600>",
                                          :medium => "300x300>", 
                                          :small  => "150x150>",
                                          :thumb  => "50x50>" }#,
                                          # :path => ":rails_root/files/:id/:style/:filename",
                                          # :url => "/files/:id/:style"
                                          
  validates_attachment :avatar, presence: true,
                                content_type: { content_type: ["image/jpeg","image/png","image/gif"] },
                                size: { in: 0..300.kilobytes }
  
  validates :expire_end_at, presence: true
  validates :expire_start_at, presence: true
  
  belongs_to :customer
  
  before_save :create_token   
  
  scope :actived, where(:active => true)   
  scope :unactive, where(:active => false)                                              
  
  
  def self.search(search)
    if search
      joins(:customer).where('customers.name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
  def state
    active? ? '已消费' : '未消费'
  end
  
  def as_json(options={})
    # super({:only => [:id, :token, :expire_start_at, :expire_end_at]})
    # .merge(thumb_image_url: avatar.url(:small), release_on: created_at.to_date)
    {
      :id => id, 
      :token => token, 
      :expire_start_at => expire_start_at, 
      :expire_end_at => expire_end_at,
      :release_on => created_at.to_date,
      :thumb_image_url => avatar.url(:small),
      :large_image_url => avatar.url(:medium)
    }
  end
  
  private 
  
  def create_token
    if new_record?
      array = []
      12.times do 
        array << rand(9) + 1
      end
      self.token = array.join('')
    end
  end
  
end
