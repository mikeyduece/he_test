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
    
    it 'should list breweries' do
      use_cassette('brew_list') do
        get api_v1_breweries_path, headers: { 'Authorization': authorization }
        json      = parse_json(response.body)
        breweries = json[:breweries]
        
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(breweries).to be_a(Array)
        expect(breweries).not_to be_empty
        expect(breweries.first).to have_key(:name)
        expect(breweries.first).to have_key(:brewery_type)
      end
    end
  
  end
end