class Api::V1::Users::UsersController < ApplicationController
  skip_before_action :doorkeeper_authorize!, only: :create
  
  def create
    user = User.create(user_params)
    if user
      success_response(201, user: serialized_resource(user, ::Users::UserBlueprint, view: :extended))
    else
      error_response('A user with that email already exists', 404)
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

end