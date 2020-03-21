class User < ApplicationRecord
  include Authentication::Doorkeeper
  
  validates :first_name, :last_name, :email, :password, presence: true
end
