module Users
  class UserBlueprint < BaseBlueprint
    identifier :id
  
    view :normal do
      fields :name, :email_address
    end
  
    view :extended do
      fields :first_name, :last_name
    end
  end
end