class User < ApplicationRecord
  include Authentication::Doorkeeper
  
  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, uniqueness: true
  
  def name
    "#{first_name} #{last_name}"
  end
end
