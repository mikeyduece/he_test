module Authentication
  module Doorkeeper
    extend ActiveSupport::Concern
    
    included do
      has_many :access_grants,
               class_name:  'Doorkeeper::AccessGrant',
               foreign_key: :resource_owner_id,
               dependent:   :destroy
      
      has_many :access_tokens,
               class_name:  'Doorkeeper::AccessToken',
               foreign_key: :resource_owner_id,
               dependent:   :destroy
    end
  end
end