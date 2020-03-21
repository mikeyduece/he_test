class User < ApplicationRecord
  include Authentication::Doorkeeper
  
end
