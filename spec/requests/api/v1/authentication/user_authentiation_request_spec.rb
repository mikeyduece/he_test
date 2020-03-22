require 'rails_helper'

describe 'User Authentication' do
  let! (:params) { {
    user: {
      first_name:   "Mike",
      last_name:    "Heft",
      phone_number: "+3530867806063",
      email:        "mikeheft@gmail.com",
      password:     "password"
    }
  } }
  let!(:user) { create(:user) }
  let(:token) { Doorkeeper::AccessToken.new(resource_owner_id: user.id) }
  
  it 'POST /api/v1/users' do
    post '/api/v1/users', params: params
    
    expect(response).to be_successful
    
    user_json = JSON.parse(response.body, symbolize_names: true)
    user = User.last
    
    expect(user_json[:user][:email]).to eq(user.email)
    expect(user_json[:user][:first_name]).to eq(user.first_name)
    expect(user_json[:user][:last_name]).to eq(user.last_name)
  end
end