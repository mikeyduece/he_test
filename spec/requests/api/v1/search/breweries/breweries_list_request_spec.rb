require 'rails_helper'

RSpec.describe 'GET /breweries', type: :request do
  context :unquthorized do
    it 'should not allow unregistered users to use the app' do
      use_cassette('unauthorized') do
        get api_v1_breweries_path
        error = parse_json(response.body)
        
        expect(response).not_to be_successful
        expect(response.status).to eq(401)
        expect(error[:error]).to eq('Not Authorized')
      end
    end
  end
  
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
    
    it 'should list breweries by city' do
      use_cassette('list_with_params') do
        get api_v1_breweries_path, params: { by_city: 'Denver' }, headers: { 'Authorization': authorization }
        json      = parse_json(response.body)
        breweries = json[:breweries]
        
        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(breweries).to be_a(Array)
        expect(breweries).not_to be_empty
        expect(breweries.first).to have_key(:name)
        expect(breweries.first).to have_key(:brewery_type)
        expect(breweries.all? { |h| h[:city].eql?('Denver') })
      end
    end
    
    it 'should paginate through params' do
      use_cassette('brew_list') do
        get api_v1_breweries_path, headers: { 'Authorization': authorization }
        json    = parse_json(response.body)
        @brew_1 = json[:breweries].first
      end
      
      use_cassette('second_page_breweries') do
        get api_v1_breweries_path, params: { page: 2 }, headers: { 'Authorization': authorization }
        json    = parse_json(response.body)
        @brew_2 = json[:breweries].first
      end
      
      expect(@brew_1[:id]).not_to eq(@brew_2[:id])
    end
  end
end