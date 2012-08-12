class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    if user.blank?
      # not logged in
      cannot :manage, :all
      basic_read_only
    elsif user.has_role?(:admin)
      # admin
      can :manage, :all
    elsif user.has_role?(:merchant)
      # 商家
      can :update, Ticket do |ticket|
        (ticket.user_id == user.id)
      end
    elsif user.has_role?(:member)
      # 注册用户
    else
      cannot :manage, :all
      basic_read_only
    end
    
  end
  
  protected
  def basic_read_only
    can :read,Ticket
  end
  
end
