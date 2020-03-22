require 'rails_helper'

RSpec.describe 'GET /breweries', type: :request do
  context :authorized do
    let(:oauth_app) {
      Doorkeeper::Application.create!(
        name:         "My Application",
        redirect_uri: "urn:ietf:wg:oauth:2.0:oob"
      )
    }
    let(:access_token) { Doorkeeper::AccessToken.create!(application: oauth_app) }
    let(:authorization) { "Bearer #{access_token.token}" }
    
    #before do
    #allow_any_instance_of(Api::V1::Search::Breweries::BreweriesController).to receive(:current_api_user) { user }
    #allow(controller).to receive(:doorkeeper_token) { token }
    #end
    before { get api_v1_breweries_path, headers: { 'Authorization': authorization } }
    
    it 'should list breweries' do
      require 'pry'; binding.pry
    
    end
  
  end
end