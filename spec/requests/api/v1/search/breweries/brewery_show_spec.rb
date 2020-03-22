require 'rails_helper'

RSpec.describe 'GET /breweries/:id' do
  context :authorized do
    let(:oauth_app) {
      Doorkeeper::Application.create!(
        name:         "My Application",
        redirect_uri: "urn:ietf:wg:oauth:2.0:oob"
      )
    }
    let(:access_token) { Doorkeeper::AccessToken.create!(application: oauth_app) }
    let(:authorization) { "Bearer #{access_token.token}" }

    it 'should show a specific brewery' do
      use_cassette('find_brewery_2') do
        get api_v1_brewery_path(2), headers: { 'Authorization': authorization }
        brewery = parse_json(response.body)
        
        expect(brewery[:id]).to eq(2)
        expect(brewery[:name]).to eq('Avondale Brewing Co')
      end
    end

    it 'should show a different brewery' do
      use_cassette('find_brewery_3') do
        get api_v1_brewery_path(3), headers: { 'Authorization': authorization }
        brewery = parse_json(response.body)
        require 'pry'; binding.pry
        expect(brewery[:id]).to eq(3)
        expect(brewery[:name]).not_to eq('Avondale Brewing Co')
      end
    end
  end
end