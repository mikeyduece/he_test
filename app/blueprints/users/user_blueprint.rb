module Users
  class UserBlueprint < BaseBlueprint
    identifier :id
  
    view :normal do
      fields :name
    end
  
    view :extended do
      fields :first_name, :last_name, :email
    end
  end
end